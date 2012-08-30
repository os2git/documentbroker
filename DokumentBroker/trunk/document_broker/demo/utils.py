"""Helper functions to retrieve data from template server and broker."""


import urllib 
import hashlib

from client.documentbroker_settings import TEMPLATE_URL, BROKER_URL
from client.documentbroker_settings import CLIENT_ID, CLIENT_PASSWORD
from client.template_client import TemplateServer
from client.broker_client import DocumentBroker


def get_templates():
    """Get all templates available for the configured client system."""
    ts = TemplateServer(TEMPLATE_URL)
    templates = ts.get_templates(CLIENT_ID)
    return [ (t[1], t[0]) for t in templates]

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
