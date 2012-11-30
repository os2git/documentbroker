# -*- coding: UTF-8 -*-
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
""" Test module for the document plugins."""

# TODO: Use proper unit test framework. For now, stick to Ellehammer test.

from plugin_manager import PluginManager

from ODFPlugin import ODFPlugin
from OOXMLPlugin import OOXMLPlugin
from PDFPlugin import PDFPlugin
from XHTMLPlugin import XHTMLPlugin


def test_plugin_defs():
    pdf_plugin = PDFPlugin()
    odf_plugin = ODFPlugin()
    ooxml_plugin = OOXMLPlugin()
    xhtml_plugin = XHTMLPlugin()

    print pdf_plugin
    print odf_plugin
    print ooxml_plugin
    print xhtml_plugin


def test_list_plugins():
    print PluginManager.list_plugins()


def test_plugin(plugin, template_path, fields, output_path, as_pdf=False):
    plugin.generate_document(template_path, output_path, fields, as_pdf)


def test_xsl_fo_plugin(plugin, template_path, fo_file):
    plugin.generate_xsl_fo_ghost_document(template_path, fo_file)


def test_image_preview_plugin(plugin, template_path, output_path, fields,
        return_format, resolusion):
    plugin.generate_preview(template_path, output_path, fields, return_format,
            resolusion)


def test_xsl_fo_plugin(plugin, template_path, fo_file):
    plugin.generate_xsl_fo_ghost_document(template_path, fo_file)


def test_odf_plugin():
    template_path = 'plugins/tests/2ca21031-72b2-4dd4-a81a-b433864e1673.ott'
    fields = {}
    fields['Leif'] = 'Carsten Agger'
    fields['Dato'] = '2012-05-01'
    fields['Svaret'] = '142'
    output_path = 'Hello.odt'
    test_plugin(ODFPlugin(), template_path, fields, output_path)


def test_xhtml_plugin():
    print "TESTING XHTML PLUGIN:"
    template_path = "plugins/tests/xhtml_template.html"
    fields = {'ceo_first_name': 'Carsten', 'ceo_last_name': 'Agger', 'date':
              '13-03-33', 'count': '42'}
    output_path = 'plugins/tests/pdf1a_output.pdf'
    test_plugin(XHTMLPlugin(), template_path, fields, output_path, as_pdf=True)


def test_xsl_fo_generation():
    print "TESTING FO FILE:"
    template_path = "plugins/tests/xhtml_template.html"
    fo_file = "plugins/tests/xhtml_template.fo"
    test_xsl_fo_plugin(XHTMLPlugin(), template_path, fo_file)


def test_xhtml_plugin_with_fo_file():
    print "TESTING GENERATION FROM FO FILE:"
    template_path = "plugins/tests/xhtml_template.fo"
    fields = {'ceo_first_name': 'Carsten', 'ceo_last_name': 'Agger', 'date':
              '13-03-33', 'count': '42'}
    output_path = 'plugins/tests/pdf1a_output.pdf'
    test_plugin(XHTMLPlugin(), template_path, fields, output_path, as_pdf=True)


def test_xhtml_image_preview_plugin(return_format="png", resolusion=48):
    print "TESTING IMG: " + return_format
    template_path = "plugins/tests/xhtml_template.html"
    fields = {'ceo_first_name': 'Carsten', 'ceo_last_name': 'Agger', 'date':
              '13-03-33', 'count': '42'}
    output_path = 'plugins/tests/pdf1a_output.png'
    test_image_preview_plugin(XHTMLPlugin(), template_path, output_path,
            fields, return_format, resolusion)


def test_xhtml_image_example_plugin(type="png", resolusion=48):
    template_path = "plugins/tests/xhtml_template.html"
    fields = {'ceo_first_name': 'Carsten', 'ceo_last_name': 'Agger', 'date':
              '13-03-33', 'count': '42'}
    output_path = 'plugins/tests/pdf1a_output.pdf'
    test_plugin(XHTMLPlugin(), template_path, output_path, resolusion,
            type)


def test_all_image_previews():
    test_xhtml_image_preview_plugin("png", 48)
    test_xhtml_image_preview_plugin("html", 24)
    test_xhtml_image_preview_plugin("tar", 24)
    test_xhtml_image_preview_plugin("zip", 24)
    test_xhtml_image_preview_plugin("tar.gz", 24)
    test_xhtml_image_preview_plugin("tar.bz2", 24)


def test_danish_characters():
    template_path = "plugins/tests/danske_tegn_fejl.html"
    fields = {'afsender_adresse': u'Blåbærgrød',
            'date': '13-03-33', 'count': '42'}
    output_path = 'plugins/tests/pdf1a_output.pdf'
    test_plugin(XHTMLPlugin(), template_path, fields, output_path, as_pdf=True)

if __name__ == '__main__':

    test_plugin_defs()
    #test_odf_plugin()
    test_xhtml_plugin()
    test_danish_characters()
    test_list_plugins()
    test_xhtml_image_preview_plugin()
    test_xsl_fo_generation()
    test_xhtml_plugin_with_fo_file()
