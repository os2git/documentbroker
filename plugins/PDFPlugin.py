"""This file implements the ODF generator plugin for the Document Broker."""

from document_plugin import DocumentPlugin


class PDFPlugin(DocumentPlugin):
    """PDF Document Plugin"""

    def __init__(self):
        """PDF related initialization, if any."""
        pass

    def generate_document(self, template_file, output_path, fields):
        """Generate PDF document from template.

        Log error and possibly throw exception in case of failure."""
        pass


