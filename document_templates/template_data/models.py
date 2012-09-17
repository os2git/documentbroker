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
from django.db.models import permalink
from django.contrib.auth.models import User
from django.utils.translation import ugettext_lazy as _

from django.conf import settings

from client.broker_client import DocumentBroker
from client.document_broker_settings import BROKER_URL
from plugins import PluginManager


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

    def _get_url(self):
        return self.file.url
    url = property(_get_url)

    def save(self, *args, **kwargs):

        # Before save
        if self.file != self._old_file:
            self.version = self.version + 1
        # Actual save
        super(Template, self).save(*args, **kwargs)
        # After save - extract field if file changed.
        if self.file != self._old_file:
            # Get plugin name from mapping
            (_, extension) = os.path.splitext(self.file.path)
            extension = extension.strip('.').upper()
            db = DocumentBroker(BROKER_URL)
            plugin_mappings = db.get_plugin_mappings()
            plugin = PluginManager.get_plugin(plugin_mappings[extension])
            fields = plugin.extract_document_fields(str(self.file.path))
            existing_fields = Field.objects.filter(document=self)

            for name, content_type in fields:
                if name not in [f.name for f in existing_fields]:
                    Field.objects.create(
                        name=name, type="TEXT",
                        content_type="string", document=self)


class Field(models.Model):
    """Document fields to be fed to the document.
    Each field is named and associated with exactly one document."""
    name = models.CharField(_('Name'), max_length=255)
    type = models.CharField(
        _('Type'),
        choices=[
            ("TEXT", _("Text")),
            ("NUMBER", _('Number')),
            ("DATE", _("Date"))
        ],
        max_length=255)
    content_type = models.CharField(
        'Content type',
        max_length=255,
        default='string')
    mandatory = models.BooleanField(_('Mandatory'), default=False)
    document = models.ForeignKey(Template, related_name='fields')
