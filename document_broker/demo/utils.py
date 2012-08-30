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
"""Helper functions to retrieve data from template server and broker."""


import urllib
import hashlib

from client.document_broker_settings import TEMPLATE_URL, BROKER_URL
from client.document_broker_settings import CLIENT_ID, CLIENT_PASSWORD
from client.template_client import TemplateServer
from client.broker_client import DocumentBroker


def get_templates():
    """Get all templates available for the configured client system."""
    ts = TemplateServer(TEMPLATE_URL)
    templates = ts.get_templates(CLIENT_ID)
    return [(t[1], t[0]) for t in templates]


def get_template_fields(template):
    """Get the fields available for the chosen template."""
    ts = TemplateServer(TEMPLATE_URL)
    return ts.get_template_fields(template)


def generate_document(template, fields):
    """Generate a document from a template."""
    db = DocumentBroker(BROKER_URL)
    user_authentication = db.get_authorization(CLIENT_ID, CLIENT_PASSWORD)
    return db.generate_document(user_authentication, template, fields)


def acknowledge_document(url):
    """Acknowledge the receipt of this document."""
    db = DocumentBroker(BROKER_URL)
    user_authentication = db.get_authorization(CLIENT_ID, CLIENT_PASSWORD)
    return db.acknowledge_document(user_authentication, url)


def validate_sha1(result_url, sha1sum):
    """Validate SHA1 hash of generated document."""
    (tmpfile, header) = urllib.urlretrieve(result_url)
    sha1 = hashlib.sha1()
    with open(tmpfile, 'rb') as f:
        sha1.update(f.read())
    return sha1.hexdigest() == sha1sum
