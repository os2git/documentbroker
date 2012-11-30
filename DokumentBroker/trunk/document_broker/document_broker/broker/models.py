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
import urllib
import hashlib

from django.conf import settings

from client.template_client import TemplateServer
from client.document_broker_settings import TEMPLATE_URL, TEMPLATE_BASE_URL
from client.document_broker_settings import BROKER_BASE_URL
from configuration.models import PluginMapping
from plugins import PluginManager
from util.helpers import get_unique_token


class DocumentBroker(object):
    """This class is not really a Django model. Rather, it implements a proxy
    which serves as a unified front for all the document-related functionality
    we need to support from the views. Thus, this is the "model" for the
    document broker, template retrieval and similar functionality which we need
    to handle the requests received by the views.

    Whereas the view functions may be protocol dependent, this model class is
    not.
    """

    def __init__(self, user_system_id):
        self._user_system_id = user_system_id

    def generate_document(self, template_id, field_data):
        """Return URL to the generated document - throw exception if not
        possible."""
        # Check user system is allowed to use template.
        ts = TemplateServer(TEMPLATE_URL)
        """
        templates = ts.get_templates(self._user_system_id)
        template_dict = {t[1]: t[2] for t in templates}
        do_pdf_dict = {t[1]: t[3] for t in templates}

        try:
            url = template_dict[template_id]
            do_pdf = do_pdf_dict[template_id]
        except KeyError:
            url = None
            raise RuntimeError(
                'Template {0} not available for client.'.format(
                    template_id)
            )
        """
        template = ts.get_template(self._user_system_id, template_id)
        if template is None:
            raise RuntimeError("Template {0} not available for client."
                .format(template_id))
        url = template[0]
        do_pdf = template[1]
        # Retrieve template from template server.
        real_url = TEMPLATE_BASE_URL + url
        file_base, extension = os.path.splitext(url)
        file_base = file_base.split('/').pop()
        tmp_name = '/tmp/{0}{1}'.format(template_id, extension)
        (fn, headers) = urllib.urlretrieve(real_url, tmp_name)

        # Finally generate document, store in appropriate place and
        # return URL.

        # Get plugin.
        plugin_mapping = PluginMapping.objects.filter(
            extension=extension.strip('.').upper()
        )[0]
        plugin = PluginManager.get_plugin(plugin_mapping.plugin)

        # Get fields from template system
        fields = ts.get_template_fields(template_id)
        # Get output file name
        unique_url = get_unique_token()
        output_dir = os.path.join(settings.MEDIA_ROOT, 'files')
        extension = 'pdf' if do_pdf else plugin_mapping.output_type
        output_file = '.'.join([unique_url, extension])
        output_path = os.path.join(output_dir, output_file)
        # TODO: Validate that fields in call exist in template, etc.
        output_url = settings.MEDIA_URL + 'files/' + output_file
        #raise RuntimeError("Not implemented: {0}".format(output_url))
        plugin.generate_document(tmp_name, output_path, field_data, do_pdf)
        # Calculate SHA1 hash of output file
        sha1 = hashlib.sha1()
        with open(output_path, 'rb') as f:
            sha1.update(f.read())
        hash = sha1.hexdigest()

        return (BROKER_BASE_URL + output_url, hash)

    def generate_preview(self, template_id, field_data,
            return_format, resolusion):
        """
        Return a URL to the generated preview.
        """
        # Check user system is allowed to use template.
        ts = TemplateServer(TEMPLATE_URL)
        templates = ts.get_templates(self._user_system_id)
        template_dict = {t[1]: t[2] for t in templates}
        do_pdf_dict = {t[1]: t[3] for t in templates}

        try:
            url = template_dict[template_id]
            do_pdf = do_pdf_dict[template_id]
        except KeyError:
            url = None
            raise RuntimeError(
                'Template {0} not available for client.'.format(
                    template_id)
            )
        # Retrieve template from template server.
        real_url = TEMPLATE_BASE_URL + url
        file_base, extension = os.path.splitext(url)
        file_base = file_base.split('/').pop()
        tmp_name = '/tmp/{0}{1}'.format(template_id, extension)
        (fn, headers) = urllib.urlretrieve(real_url, tmp_name)

        # Finally generate document, store in appropriate place and
        # return URL.

        # Get plugin.
        plugin_mapping = PluginMapping.objects.filter(
            extension=extension.strip('.').upper()
        )[0]
        plugin = PluginManager.get_plugin(plugin_mapping.plugin)

        # Get fields from template system
        fields = ts.get_template_fields(template_id)
        # Get output file name
        unique_url = get_unique_token()
        output_dir = os.path.join(settings.MEDIA_ROOT, 'files')
        extension = return_format
        output_file = '.'.join([unique_url, extension])
        output_path = os.path.join(output_dir, output_file)
        # TODO: Validate that fields in call exist in template, etc.
        output_url = settings.MEDIA_URL + 'files/' + output_file
        #raise RuntimeError("Not implemented: {0}".format(output_url))
        plugin.generate_preview(tmp_name, output_path, field_data,
                return_format, resolusion)
        # Calculate SHA1 hash of output file
        sha1 = hashlib.sha1()
        with open(output_path, 'rb') as f:
            sha1.update(f.read())
        hash = sha1.hexdigest()
        return (BROKER_BASE_URL + output_url, hash)

    def generate_template_image(self, template_id, resolusion, image_type,
            file_name):
        """
        Return a URL to the generated preview.
        """
        # Check user system is allowed to use template.
        ts = TemplateServer(TEMPLATE_URL)
        templates = ts.get_templates(self._user_system_id)
        template_dict = {t[1]: t[2] for t in templates}
        do_pdf_dict = {t[1]: t[3] for t in templates}

        try:
            url = template_dict[template_id]
            do_pdf = do_pdf_dict[template_id]
        except KeyError:
            url = None
            raise RuntimeError(
                'Template {0} not available for client.'.format(
                    template_id)
            )
        # Retrieve template from template server.
        real_url = TEMPLATE_BASE_URL + url
        file_base, extension = os.path.splitext(url)
        file_base = file_base.split('/').pop()
        tmp_name = '/tmp/{0}{1}'.format(template_id, extension)
        (fn, headers) = urllib.urlretrieve(real_url, tmp_name)

        # Finally generate document, store in appropriate place and
        # return URL.

        # Get plugin.
        plugin_mapping = PluginMapping.objects.filter(
            extension=extension.strip('.').upper()
        )[0]
        plugin = PluginManager.get_plugin(plugin_mapping.plugin)

        # Get fields from template system
        fields = ts.get_template_fields(template_id)
        # Get output file name
        unique_url = get_unique_token()
        output_dir = os.path.join(settings.MEDIA_ROOT, 'files')
        extension = ".png"
        output_file = file_name[:file_name.rfind('.')] + "_" + image_type
        output_file += extension
        output_path = os.path.join(output_dir, output_file)
        # TODO: Validate that fields in call exist in template, etc.
        output_url = settings.MEDIA_URL + 'files/' + output_file
        print "generate_template_image IS RUN"
        plugin.generate_template_image(tmp_name, output_path, resolusion,
                image_type)

        # Calculate SHA1 hash of output file
        sha1 = hashlib.sha1()
        with open(output_path, 'rb') as f:
            sha1.update(f.read())
        hash = sha1.hexdigest()
        return (BROKER_BASE_URL + output_url, hash)

    def generate_fo_template(self, template_id, fo_file):
        """
        Return a URL to the generated preview.
        """
        # Check user system is allowed to use template.
        ts = TemplateServer(TEMPLATE_URL)
        templates = ts.get_templates(self._user_system_id)
        template_dict = {t[1]: t[2] for t in templates}
        do_pdf_dict = {t[1]: t[3] for t in templates}
        print "TEMPLATE_ID: " + template_id
        print "TEMPLATES: " + str(template_dict)

        try:
            url = template_dict[template_id]
            do_pdf = do_pdf_dict[template_id]
        except KeyError:
            url = None
            raise RuntimeError(
                'Template {0} not available for client.'.format(
                    template_id)
            )
        # Retrieve template from template server.
        real_url = TEMPLATE_BASE_URL + url
        file_base, extension = os.path.splitext(url)
        file_base = file_base.split('/').pop()
        tmp_name = '/tmp/{0}{1}'.format(template_id, extension)
        (fn, headers) = urllib.urlretrieve(real_url, tmp_name)

        # Get plugin.
        plugin_mapping = PluginMapping.objects.filter(
            extension=extension.strip('.').upper()
        )[0]
        plugin = PluginManager.get_plugin(plugin_mapping.plugin)

        # Get output file name
        unique_url = get_unique_token()
        output_dir = os.path.join(settings.MEDIA_ROOT, 'files')
        extension = "fo"
        output_file = '.'.join([unique_url, extension])
        output_path = os.path.join(output_dir, output_file)
        output_url = settings.MEDIA_URL + 'files/' + output_file
        plugin.generate_xsl_fo_ghost_document(tmp_name, output_path)

        # Calculate SHA1 hash of output file
        sha1 = hashlib.sha1()
        with open(output_path, 'rb') as f:
            sha1.update(f.read())
        hash = sha1.hexdigest()
        return (BROKER_BASE_URL + output_url, hash)

    def acknowledge_document(self, document_url):
        file_name = document_url.split('/').pop()
        file_path = os.path.join(
            settings.MEDIA_ROOT,
            os.path.join('files', file_name)
        )
        try:
            os.remove(file_path)
        except OSError:
            # TODO: Log this.
            pass
        return 0
