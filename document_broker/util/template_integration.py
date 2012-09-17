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
"""
This file contains functions and classes that help extract information from
the template system.

"""


def get_templates(client_system):
    """Return a list of all templates available for this ClientSystem."""
    # TODO: Implement this.


def get_template_data(id, client_system):
    """Retrieve template name and URL from template server based on UUID
    supplied by client system when calling. The template system will refuse to
    supply the data if the client system does not have access to this
    template."""
    # TODO: Implement this
    return Template("None", "http://www.nowhere.org/nothing.ott")
