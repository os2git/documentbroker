# Copyright (C) 2012  Magenta ApS.
#
# Authors: Carsten Agger (carstena@magenta-aps.dk),
#          Dennis Isaksen (dennis@magenta-aps.dk),
#          Leif Lodahl (leif@magenta-aps.dk)
#
# This file is part of the Magenta Document Broker.
#
# The Magenta Document Broker is free software: you can redistribute it
# and/or modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranties of
# MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR
# PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program.  If not, see <http://www.gnu.org/licenses/>.
"""This file implements the XHTML generator plugin for the Document Broker."""

import re
from lxml import etree
from cgi import escape

from document_plugin import DocumentPlugin
from xhtml_plugin import get_xhtml2pdf
from xhtml_plugin import FOP, PISA

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
        """Generate XHTML document from template.

        Log error and possibly throw exception in case of failure."""
        try:
            with open(template_path, 'r') as f:
                xhtml_string = f.read()  # slurp!
                for (field, value) in fields.items():
                    # Remove possibly noxious HTML tags from input
                    value = escape(value)
                    value = value.encode('utf8')
                    xhtml_string = xhtml_string.replace('#' + field, value)

            if as_pdf:
                xhtml2pdf(xhtml_string, output_path)
            else:
                with open(output_path, 'w') as f:
                    f.write(xhtml_string)

        except Exception as e:
            raise

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
