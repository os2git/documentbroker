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
"""This file implements the ODF generator plugin for the Document Broker."""

import sys

from document_plugin import DocumentPlugin


class ODFPlugin(DocumentPlugin):
    """ODF Document Plugin"""

    def __init__(self):
        """ODF related initialization, if any."""
        pass

    def generate_document(self, template_file, output_path, fields,
            as_pdf=False):
        """Generate ODF document from template.

        Log error and possibly throw exception in case of failure."""
        from util.odf_generator import generate_odf

        try:
            generate_odf(template_file, fields, output_path)
        except Exception as e:
            # TODO: Proper error logging here, many thanks!
            sys.stderr.write("Error found: " + str(e))
            raise

    def extract_document_fields(self, path):
        """Extract fields from ODF template, return as list of field names."""
        from lpod.document import odf_get_document

        document = odf_get_document(path)
        content = document.get_content()
        body = content.get_body()
        fields = body.get_user_field_decl_list()

        return [
            (item.get_attribute("text:name"),
                item.get_attribute("office:value-type")) for item in fields
        ]


if __name__ == '__main__':

    fields = {}
    fields['Leif'] = ('LeifLeifLeif', 'string')
    fields['Dato'] = ('2012-05-11', 'date')
    fields['Svaret'] = ('137', 'string')
    #fields['document_creator'] = ('Document Broker ODF Plugin', 'string')

    odf_plugin = ODFPlugin()
    odf_plugin.generate("/home/carstena/src/document_broker/research/Test.ott",
                        "output.odf", fields)
