"""This file implements the ODF generator plugin for the Document Broker."""

import sys

from util.document_plugin import DocumentPlugin
from util.odf_generator import generate_odf

class ODFPlugin(DocumentPlugin):

    def __init__(self):
        """ODF related initialization, if any."""
        pass

    def generate(self, template_file, output_path, fields):
        """Generate ODF document from template.

        Log error and possibly throw exception in case of failure."""
        try:
            generate_odf(template_file, fields, output_path)
        except Exception as e:
            # TODO: Proper error logging here, many thanks!
            sys.stderr.write("Error found: " + str(e))



if __name__ == '__main__':
    

    fields = {}
    fields['Leif'] = ('LeifLeifLeif', 'string')
    fields['Dato'] = ('2012-05-11', 'date')
    fields['Svaret'] = ('137', 'string')
    #fields['document_creator'] = ('Document Broker ODF Plugin', 'string')

 
    odf_plugin = ODFPlugin()
    odf_plugin.generate("/home/carstena/src/document_broker/research/Test.ott",
                        "output.odf", fields)


