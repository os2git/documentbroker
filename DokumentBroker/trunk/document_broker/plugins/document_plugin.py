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


class DocumentPlugin(object):
    """This is the superclass for all document plugins.

       This is an abstract superclass - all knowledge of different document
       formats, even their names and their existence, is relegated to the
       actual plugins.
    """

    _NOT_IMPL = "Not implemented - please implement in subclass."

    def generate_document(self, template_file, output_path, fields,
            as_pdf=False):
        """Generate a document using the file *template_file*, place the
        resulting document in the path given by *document_path*.

        Use the fields specified in the dictionary *fields* to generate the
        document. This dictionary is a simple mapping from name  to (value,
        type).
        """
        raise RuntimeError(self._NOT_IMPL)

    def extract_document_fields(self, path):
        """Extract the fields needed to generate document."""
        raise RuntimeError(self._NOT_IMPL)
