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
"""
This file contains functions and classes that help extract information from
the template system.

"""


class TemplateData(object):
    """Represents a simple template retrieved from the template system."""
    __init__(self, name, url):
        self.name = name
        self.url = url


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
