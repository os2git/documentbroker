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
