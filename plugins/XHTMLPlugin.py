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
"""This file implements the XHTML generator plugin for the Document Broker."""

import re
import os
from lxml import etree
from cgi import escape

from django.conf import settings
from document_plugin import DocumentPlugin
from xhtml_plugin import get_xhtml2pdf, get_fo, fo2pdf
from xhtml_plugin import FOP, PISA
from xhtml_plugin.preview_generator import ImagePreview

FILE_DIR = 'xhtml_plugin'

xhtml2pdf = get_xhtml2pdf(method=FOP)


class ExtractFieldsTarget(object):
    """Class to extract fields from an XML document. We assume user fields are
    prefixed with a '#'. The regular expression to recognize these fields might
    also be part of the setup and passed in the init function."""

    is_style = lambda self, s: s.lower() == 'style'

    @staticmethod
    def html_tag(tag):
        XHTML_NS = '{http://www.w3.org/1999/xhtml}'
        new_tag = tag[len(XHTML_NS):] if tag.startswith(XHTML_NS) else tag
        return new_tag

    def __init__(self, fields):
        self._fields = fields
        self._in_style_tag = False
        self._current_tag = ''

    def start(self, tag, attrib):
        tag = self.html_tag(tag)
        if self.is_style(tag):
            self._in_style_tag = True
        self._current_tag = tag

    def end(self, tag):
        tag = self.html_tag(tag)
        if self.is_style(tag):
            self._in_style_tag = False
        self._current_tag = ''

    def data(self, data):
        if not self._in_style_tag:
            user_fields = re.findall(r'#\w+', data)
            for w in user_fields:
                self._fields.append(w[1:])

    def comment(self, text):
        pass

    def close(self):
        pass


class XHTMLPlugin(DocumentPlugin):
    """XHTML Document Plugin"""

    def __init__(self):
        """XHTML related initialization, if any."""
        pass

    def generate_document(self, template_path, output_path, fields,
            as_pdf=False):
        """Generate PDF/XHTML document from template.

        Log error and possibly throw exception in case of failure."""
        try:
            #xhtml2pdf(xhtml_string, output_path)
            """
            Instead of generating PDF documents from XHTML templates
            we do it from XSL-FO templates:
            """
            # TODO:
            # We should probably check if an XSL-FO ghost template
            # actually exists before attempting to use it.
            # For now we assume it exists:
            if as_pdf:
                with open(template_path, 'r') as f:
                    contents_string = f.read()  # slurp!
                    for (field, value) in fields.items():
                        # Remove possibly noxious HTML tags from input
                        value = escape(value)
                        value = value.encode('utf-8')
                        contents_string = contents_string.replace(
                                '#' + field, value
                        )
                ext = template_path[(template_path.rfind(".") + 1):].upper()
                if ext == "FO":
                    fo2pdf(contents_string, output_path)
                else:
                    xhtml2pdf(contents_string, output_path)
            else:
                with open(template_path, 'r') as f:
                    xhtml_string = f.read()  # slurp!
                    for (field, value) in fields.items():
                        # Remove possibly noxious HTML tags from input
                        value = escape(value)
                        value = value.encode('utf-8')
                        xhtml_string = xhtml_string.replace('#' + field, value)
                with open(output_path, 'w') as f:
                    f.write(xhtml_string)

        except Exception as e:
            raise

    def generate_xsl_fo_ghost_document(self, template_path, fo_file):
        fo_file = os.path.join(settings.MEDIA_ROOT, fo_file)
        """Generate XSL-FO document from template.

        Log error and possibly throw exception in case of failure."""
        try:
            with open(template_path, 'r') as f:
                contents_string = f.read()  # slurp!
                get_fo(contents_string, fo_file)
        except Exception as e:
            raise

    def generate_preview(self, template_path, output_path, fields,
        return_format, resolusion):
        """Generate preview from template.

        Log error and possibly throw exception in case of failure."""
        extension = template_path[template_path.rfind("."):]
        try:
            with open(template_path, 'r') as f:
                xhtml_string = f.read()  # slurp!
                if fields is not None:
                    for (field, value) in fields.items():
                        # Remove possibly noxious HTML tags from input
                        value = escape(value)
                        value = value.encode('utf8')
                        xhtml_string = xhtml_string.replace('#' +
                            field, value)
            if resolusion == 0:
                resolusion = 72
            ImagePreview.generate_preview(xhtml_string, output_path,
                return_format, resolusion, extension)
        except Exception as e:
            raise

    def generate_template_image(self, template_path, output_path, resolusion,
            image_type):
        """Generate preview from template.

        Log error and possibly throw exception in case of failure."""
        extension = template_path[template_path.rfind("."):]
        with open(template_path, 'r') as f:
            xhtml_string = f.read()  # slurp!
        ImagePreview.generate_template_image(
            xhtml_string, output_path, image_type, resolusion, extension
        )

    def extract_document_fields(self, path):
        """Extract fields from XHTML template, return (field, value_type)
        list."""
        # Validate XHTML, parse and extract fields.
        fields = []
        target = ExtractFieldsTarget(fields)
        parser = etree.XMLParser(ns_clean=True,
                remove_blank_text=True,
                target=target)
        tree = etree.parse(path, parser)

        return [(f, 'string') for f in set(fields)]
