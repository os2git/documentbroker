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

from document_plugin import DocumentPlugin


class PDFPlugin(DocumentPlugin):
    """PDF Document Plugin"""

    def __init__(self):
        """PDF related initialization, if any."""
        pass

    def generate_document(self, template_file, output_path, fields, ):
        """Generate PDF document from template.

        Log error and possibly throw exception in case of failure."""
        pass
