""" Test module for the document plugins."""

# TODO: Use proper unit test framework. For now, stick to Ellehammer test.

from ODFPlugin import ODFPlugin
from OOXMLPlugin import OOXMLPlugin
from PDFPlugin import PDFPlugin

def test_plugin_defs():
    pdf_plugin = PDFPlugin()
    odf_plugin = ODFPlugin()
    ooxml_plugin = OOXMLPlugin()

    print pdf_plugin
    print odf_plugin
    print ooxml_plugin

def test_odf_plugin():
    odf_plugin = ODFPlugin()
    template_path = '2ca21031-72b2-4dd4-a81a-b433864e1673.ott'
    fields = {}
    fields['Leif'] = 'Carsten Agger'
    fields['Dato'] = '2012-05-01'
    fields['Svaret'] = '142'
    output_path = 'Hello.odt'                 
    odf_plugin.generate_document(template_path, output_path, fields)

if __name__ == '__main__':

    test_plugin_defs()
    test_odf_plugin()

