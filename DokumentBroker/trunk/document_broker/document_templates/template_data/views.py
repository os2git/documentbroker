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

import sys

from django.conf import settings
from models import Template, ClientSystem, Field


def get_templates(client_system_id):
    """List all templates for this client system"""
    url_prefix = settings.MEDIA_URL
    templates = Template.objects.filter(available_for__uuid=client_system_id)
    sys.stderr.write("Client system: {0}\n".format(client_system_id))
    sys.stderr.write(str(templates) + 'Antal: ' + str(len(templates)) + '\n')
    return [
            (t.name, t.uuid, url_prefix + t.file.name, t.do_output_pdf)
            for t in templates]


def get_template_fields(template_id):
    """List all fields for this template"""
    template = Template.objects.get(uuid=template_id)
    fields = Field.objects.filter(document=template)
    return [f.name for f in fields]


def get_template_url(client_system_id, template_id):
    # TODO: Do we need this?
    pass
