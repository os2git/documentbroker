# Copyright (C) 2012  Magenta ApS.
#
# Authors: Carsten Agger (carstena@magenta-aps.dk),
#          Dennis Isaksen (dennis@magenta-aps.dk),
#          Leif Lodahl (leif@magenta-aps.dk)
#
# This file is part of the Magenta Document Broker.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranties of
# MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR
# PURPOSE.  See the Mozilla Public License for more details.

import os
import uuid

from django.db import models
from django.db.models.signals import post_save
from django.db.models import permalink
from django.contrib.auth.models import User
from django.utils.translation import ugettext_lazy as _

from django.conf import settings

from client.broker_client import DocumentBroker
from client import document_broker_settings
from plugins import PluginManager
import xmlrpclib
import urllib
import threading
import time


class ClientSystem(models.Model):
    """Represents the client system as in the Document Broker.
    In fact, the uuid field MUST be identical to the corresponding uuid in the
    broker. Should this be automated? For the time being, hand carry."""
    name = models.CharField(_('Name'), max_length=255)
    uuid = models.CharField(_('Id'), max_length=255)  # uuid in Document Broker
    description = models.TextField(_('Description'), max_length=1024)
    client = models.CharField(_('Client'), max_length=255)  # DOMAIN?

    def __unicode__(self):
        return ', '.join([self.name, self.client])


class BrokerServer:
    """
    This is meant for the template server to perform operations on the broker.
    At the moment only generate_template_image, generate_fo_template and
    acknowledge_document
    """

    def __init__(self, url, verbose=False):
        # For now, don't try/catch - just pass on
        # any exception that might occur in the transport
        # layer. We can improve that later, if need be.
        # TODO: Introduce user authentication.
        self._url = url
        self._rpc_srv = xmlrpclib.ServerProxy(self._url, verbose=verbose)
        # This is for development purpose. authorization should be carried
        # out otherwise in production.
        self._authorization = self._rpc_srv.get_authorization(
            document_broker_settings.CLIENT_ID,
            document_broker_settings.CLIENT_PASSWORD
        )

    def get_plugin_mappings(self):
        return self._rpc_srv.get_plugin_mappings()

    def generate_fo_template(self, template_id, fo_file_path):
        return self._rpc_srv.generate_fo_template(self._authorization,
                template_id, fo_file_path)

    def generate_template_image(self, template_id, resolusion, image_type,
            file_path):
        return self._rpc_srv.generate_template_image(self._authorization,
                template_id, resolusion, image_type, file_path)

    def acknowledge_document(self, document):
        return self._rpc_srv.acknowledge_document(self._authorization,
                document)


_bs = None


def set_broker_server(bs):
    """
    We make an instance of the broker server globally available.
    """
    global _bs
    _bs = bs


def get_broker_server():
    return _bs


class create_supporting_files(threading.Thread):
    _fo_file_path = None
    _file_path = None
    _uuid = None

    def addData(self, uuid, file_path, fo_file_path):
        self._fo_file_path = fo_file_path
        self._file_path = file_path
        self._uuid = uuid

    def run(self):
        print "THREAD RUNNING"
        """
        This method is called when a template is saved.
        We create the fo file and the image files here.
        """
        template_ready = False
        count = 0
        while (not template_ready):
            the_file = os.path.join(
                settings.MEDIA_ROOT,
                "files/" + self._file_path
            )
            template_ready = os.path.isfile(
                os.path.join(
                    settings.MEDIA_ROOT,
                    "files/" + self._file_path
                )
            )
            print str(the_file) + " NOT READY " + str(count)
            count += 1
            time.sleep(1)
        bs = get_broker_server()
        (_, extension) = os.path.splitext(self._file_path)
        extension = extension.strip('.').upper()
        if (
                extension == "HTML"
                or extension == "XHTML"
                or extension == "HTM"
                and self.do_output_pdf
        ):
            if self._fo_file_path != "":
                """ We generate an XSL-FO template """
                (fo_url, hash) = bs.generate_fo_template(
                        self._uuid, self._fo_file_path)
                try:
                    """ We fetch and save the file """
                    fo_handle = urllib.urlopen(fo_url)
                    fo_data = fo_handle.read()
                    fo_handle.close
                except Exception as e:
                    print "An error ocurred while reading the FO file: "
                try:
                    with open(os.path.join(
                        settings.MEDIA_ROOT, self._fo_file_path
                    ), 'w') as fo_out:
                        fo_out.write(str(fo_data))
                    fo_out.close
                except Exception as e:
                    print "An error ocurred while saving the FO file: "
                """ check the hash sum """
                # TODO: do the check
                """ And finally we acknowledge the file on the broker. """
                bs.acknowledge_document(self._fo_file_path[
                    self._fo_file_path.rfind('/'):])

            """
            We generate a thumbnail image and an example image for the
            new xhtml file and name them alike.
            """
            (ex_url, hash) = bs.generate_template_image(self._uuid,
                settings.TEMPLATE_EXAMPLE_RESOLUSION,
                "example", self._file_path
            )
            try:
                """ We fetch and save the file """
                ex_handle = urllib.urlopen(ex_url)
                ex_data = ex_handle.read()
                ex_handle.close
            except Exception as e:
                print "An error ocurred while reading the EX file: " + str(e)
            ex_file_path = "files" + ex_url[ex_url.rfind('/'):]
            try:
                with open(os.path.join(
                    settings.MEDIA_ROOT, ex_file_path
                ), 'w') as ex_out:
                    ex_out.write(str(ex_data))
                ex_out.close
            except Exception as e:
                print "An error ocurred while saving the EX file: " + str(e)
            """ check the hash sum """
            # TODO: do the check
            """ And finally we acknowledge the file on the broker. """
            bs.acknowledge_document(ex_file_path[ex_file_path.rfind('/'):])

            (th_url, hash) = bs.generate_template_image(self._uuid,
                settings.THUMBNAIL_RESOLUSION,
                "thumbnail", self._file_path
            )
            try:
                """ We fetch and save the file """
                th_handle = urllib.urlopen(th_url)
                th_data = th_handle.read()
                th_handle.close
            except Exception as e:
                print "An error ocurred while reading the TH file: " + str(e)
            th_file_path = "files" + th_url[th_url.rfind('/'):]
            try:
                with open(os.path.join(
                    settings.MEDIA_ROOT, th_file_path
                ), 'w') as th_out:
                    th_out.write(str(th_data))
                th_out.close
            except Exception as e:
                print "An error ocurred while saving the TH file: " + str(e)
                """ check the hash sum """
            # TODO: do the check
            """ And finally we acknowledge the file on the broker. """
            bs.acknowledge_document(th_file_path[th_file_path.rfind('/'):])


def sup_files_in_thread(sender, instance, created, **kwargs):
    t = create_supporting_files()
    tmp_file = instance.file.path[(instance.file.path.rfind('/') + 1):]
    t.addData(instance.uuid, tmp_file, instance.precompiled_file)
    t.start()


class Template(models.Model):
    """Contains all metadata for the templates."""

    def __init__(self, *args, **kwargs):
        super(Template, self).__init__(*args, **kwargs)
        self._old_file = self.file
    uuid = models.CharField(_('Id'),
                            max_length=36,
                            default=lambda: unicode(uuid.uuid4()),
                            editable=True, unique=True)
    name = models.CharField(_('Name'), max_length=255)
    version = models.IntegerField(_('Version'), default=0)
    type = models.CharField(
        _('Type'), max_length=255,
        choices=[
            ("ODT", _("ODT Template")),
            ("DOCX", _("OOXML Template")),
            ("XHTML", _("XHTML Template"))
        ])
    do_output_pdf = models.BooleanField(_('PDF output'), default=False)
    status = models.IntegerField(_('Status'), choices=[
        (0, _('Inaktiv')),
        (1, _('Aktiv')),
    ])

    # available_for - list of systems - foreign key
    available_for = models.ManyToManyField(ClientSystem,
                                           verbose_name=_('Available for'),
                                           related_name='templates')
    """ TODO: MISSING FIELDS, FIND OUT WHAT TO DO ABOUT THESE."""
    # context - list of available contexts - foreign key
    # category - keyword, chosen from one of several categories
    # owner - users with right to use this template.
    """ END TODO."""

    file = models.FileField(_('File'), upload_to='files')

    precompiled_file = models.CharField(_('precompiled_file'), max_length=255,
        default="")

    def _get_url(self):
        return self.file.url
    url = property(_get_url)

    def save(self, *args, **kwargs):
        fo_file_path = ""
        bs = BrokerServer(document_broker_settings.BROKER_URL)
        set_broker_server(bs)
        # Before save
        if self.file != self._old_file:
            self.version = self.version + 1
            """
            We check if template contains HTML input fields.
            """
            file_contents = self.file.read()
            if not "#[HTML]" in file_contents:
                """
                Couldn't make the commit keyword work on the save method.
                pre_save=
                super(Template, self).save(commit=False, *args, **kwargs)
                Except: save() got an unexpected keyword argument 'commit'

                This is a dirty way to find the next file:
                """
                found = True
                i = 0
                while found:
                    """
                    We traverse the files with this name and set the fo output
                    file to be the next one in the row.
                    """
                    wo_ext = str(self.file.name)
                    wo_ext = wo_ext[:str(self.file.name).rfind(".")]
                    ext = str(self.file.name)[str(self.file.name).rfind("."):]
                    if i == 0:
                        file_name = "files/"
                        file_name += wo_ext
                    else:
                        file_name += wo_ext
                        file_name += "_" + str(i)
                    try:
                        the_file = os.path.join(
                            settings.MEDIA_ROOT,
                            file_name + ext
                        )
                        with open(the_file, 'r') as f:
                            file_name = "files/"
                            found = True
                    except Exception as e:
                        fo_file_path = file_name + ".fo"
                        found = False
                    i += 1
                self.precompiled_file = fo_file_path
        plugin_mappings = bs.get_plugin_mappings()
        # Actual save
        super(Template, self).save(*args, **kwargs)
        # After save - extract field if file changed.
        if self.file != self._old_file:
            # Get plugin name from mapping
            (_, extension) = os.path.splitext(self.file.path)
            extension = extension.strip('.').upper()
            db = DocumentBroker(document_broker_settings.BROKER_URL)
            plugin_mappings = db.get_plugin_mappings()
            plugin = PluginManager.get_plugin(plugin_mappings[extension])
            fields = plugin.extract_document_fields(str(self.file.path))
            existing_fields = Field.objects.filter(document=self)

            for name, content_type in fields:
                if name not in [f.name for f in existing_fields]:
                    """ We set the default input type to be text. """
                    input_type = "TEXT"
                    """
                    We check if the field take HTML input and declare the input
                    type alike.
                    """
                    if len(name) > 7:
                        if name[:6] == "[HTML]":
                            input_type = "HTML"
                            self.precompiled_file = None
                    Field.objects.create(
                        name=name, type=input_type,
                        content_type="string", document=self)


post_save.connect(sup_files_in_thread, sender=Template)


class Field(models.Model):
    """Document fields to be fed to the document.
    Each field is named and associated with exactly one document."""
    name = models.CharField(_('Name'), max_length=255)
    type = models.CharField(
        _('Type'),
        choices=[
            ("TEXT", _("Text")),
            ("NUMBER", _('Number')),
            ("DATE", _("Date")),
            ("HTML", _("HTML"))
        ],
        max_length=255)
    content_type = models.CharField(
        'Content type',
        max_length=255,
        default='string')
    mandatory = models.BooleanField(_('Mandatory'), default=False)
    document = models.ForeignKey(Template, related_name='fields')
