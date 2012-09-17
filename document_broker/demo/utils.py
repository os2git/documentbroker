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
