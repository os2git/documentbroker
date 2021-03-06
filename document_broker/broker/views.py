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

from django.utils.translation import ugettext as _

from models import DocumentBroker
from utils import authorized, is_valid_login, create_authorization
from utils import get_client_id

import sys

from configuration.models import ClientSystem, PluginMapping


def get_authorization(client_id, password):
    """Authorize client and return control block to be used in subsequent API
    calls."""
    if is_valid_login(client_id, password):
        return create_authorization(client_id, password)
    else:
        raise RuntimeError(_('Authorization failed'))


def get_plugin_mappings():
    plugin_mappings = PluginMapping.objects.all()
    return {pm.extension: pm.plugin for pm in plugin_mappings}


@authorized
def get_client_systems(user_authentication):
    client_systems = ClientSystem.objects.all()
    return {c.name: c.uuid for c in client_systems}


@authorized
def generate_document(user_authentication, template_id, fields):
    """Get template from template server and generates document.
    Store document in suitable place and return URL to retrieve it."""

    clid = get_client_id(user_authentication)
    broker = DocumentBroker(clid)
    return broker.generate_document(template_id, fields)


@authorized
def generate_fo_template(user_authentication, template_id, fo_file):
    """Get template from template server and generates fo template.
    Store document in suitable place and return URL to retrieve it."""

    clid = get_client_id(user_authentication)
    broker = DocumentBroker(clid)
    return broker.generate_fo_template(template_id, fo_file)


@authorized
def generate_template_image(user_authentication, template_id, resolusion,
        image_type, file_path):
    """Get template from template server and generates a preview.
    Store preview in suitable place and return URL to retrieve it."""

    clid = get_client_id(user_authentication)
    broker = DocumentBroker(clid)
    return broker.generate_template_image(template_id, resolusion, image_type,
            file_path)


@authorized
def generate_preview(user_authentication, template_id, fields, return_format,
        resolusion):
    """Get template from template server and generates a preview.
    Store preview in suitable place and return URL to retrieve it."""

    clid = get_client_id(user_authentication)
    broker = DocumentBroker(clid)
    return broker.generate_preview(template_id, fields, return_format,
            resolusion)


@authorized
def acknowledge_document(user_authentication, document):
    """Acknowledge the retrieval of a document generated by a previous
    request. Deletes the generated document, so that it's no more
    available."""
    clid = get_client_id(user_authentication)
    broker = DocumentBroker(clid)
    return broker.acknowledge_document(document)
