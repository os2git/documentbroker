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
import os

from django.conf import settings
from models import Template, ClientSystem, Field
from utils import check_ssl_connection


def get_templates(client_system_id):
    """List all templates for this client system"""
    check_ssl_connection()
    url_prefix = settings.MEDIA_URL
    templates = Template.objects.filter(available_for__uuid=client_system_id)
    sys.stderr.write("Client system: {0}\n".format(client_system_id))
    sys.stderr.write(str(templates) + 'Antal: ' + str(len(templates)) + '\n')
    return_data = []
    for t in templates:
        file_path = os.path.join(settings.MEDIA_ROOT, t.file.name)
        thumb_file = file_path[:file_path.rfind('.')] + "_thumbnail.png"
        if (os.path.isfile(thumb_file)):
            has_thumb = True
        else:
            has_thumb = False
        return_data.append(
            (
                t.name,
                t.uuid,
                url_prefix + t.file.name,
                t.do_output_pdf,
                has_thumb
            )
        )
    sys.stderr.write("DATA: " + str(return_data))
    return return_data


def get_template_fields(template_id):
    """List all fields for this template"""
    check_ssl_connection()
    template = Template.objects.get(uuid=template_id)
    fields = Field.objects.filter(document=template)
    return [f.name for f in fields]


def get_template_fields_adv(template_id):
    """List all fields for this template with additional data"""
    check_ssl_connection()
    template = Template.objects.get(uuid=template_id)
    fields = Field.objects.filter(document=template)
    return [f for f in fields]


def get_template(client_system_id, template_id):
    """
    Returns the requested template if it exists otherwise None is returnes
    """
    check_ssl_connection()
    url_prefix = settings.MEDIA_URL
    template = Template.objects.filter(
        available_for__uuid=client_system_id
    ).filter(uuid__exact=template_id)
    if template[0].precompiled_file != "":
        return_file = template[0].precompiled_file
    else:
        return_file = template[0].file.name
    try:
        return (url_prefix + return_file, template[0].do_output_pdf)
    except KeyError:
        return None


def get_template_url(client_system_id, template_id):
    # TODO: Do we need this?
    pass


def get_thumbnail_image(template_id):
    """
    Returns the thumbnail image for the requested template
    """
    url_prefix = settings.MEDIA_URL
    template = Template.objects.get(uuid=template_id)
    thumb_file = template.file.name[:template.file.name.rfind('.')]
    thumb_file += "_thumbnail.png"
    if os.path.isfile(os.path.join(settings.MEDIA_ROOT, thumb_file)):
        return os.path.join(settings.MEDIA_URL, thumb_file)
    else:
        return ""


def get_example_image(template_id):
    """
    Returns the example image for the requested template
    """
    url_prefix = settings.MEDIA_URL
    template = Template.objects.get(uuid=template_id)
    example_file = template.file.name[:template.file.name.rfind('.')]
    example_file += "_example.png"
    if os.path.isfile(os.path.join(settings.MEDIA_ROOT, example_file)):
        return os.path.join(settings.MEDIA_URL, example_file)
    else:
        return ""
