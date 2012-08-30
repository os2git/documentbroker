"""This file implements the ODF generator plugin for the Document Broker."""

from util.document_plugin import DocumentPlugin


class OOXMLPlugin(DocumentPlugin):

    def __init__(self):
        """ODF related initialization, if any."""
        pass

    def generate(self, template_file, output_path, fields):
        """Generate ODF document from template.

        Log error and possibly throw exception in case of failure."""
        pass


