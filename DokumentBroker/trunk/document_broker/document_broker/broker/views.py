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
def acknowledge_document(user_authentication, document):
    """Acknowledge the retrieval of a document generated by a previous
    request. Deletes the generated document, so that it's no more
    available."""
    clid = get_client_id(user_authentication)
    broker = DocumentBroker(clid)
    return broker.acknowledge_document(document)