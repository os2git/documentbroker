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
"""This file implements the ODF generator plugin for the Document Broker."""

from document_plugin import DocumentPlugin


class OOXMLPlugin(DocumentPlugin):
    """OOXML Document Plugin"""

    def __init__(self):
        """OOXML related initialization, if any."""
        pass

    def generate_document(self, template_file, output_path, fields,
            as_pdf=False):
        """Generate OOXML document from template.

        Log error and possibly throw exception in case of failure."""
        pass
