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


if __name__ == '__main__':

    test_plugin_defs()
