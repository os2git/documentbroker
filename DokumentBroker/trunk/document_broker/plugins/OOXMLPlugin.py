"""This file implements the ODF generator plugin for the Document Broker."""

from document_plugin import DocumentPlugin


class OOXMLPlugin(DocumentPlugin):
    """OOXML Document Plugin"""

    def __init__(self):
        """OOXML related initialization, if any."""
        pass

    def generate_document(self, template_file, output_path, fields):
        """Generate OOXML document from template.

        Log error and possibly throw exception in case of failure."""
        pass


