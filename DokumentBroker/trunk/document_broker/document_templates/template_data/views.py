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
