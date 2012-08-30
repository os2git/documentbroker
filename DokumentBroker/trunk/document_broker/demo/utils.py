"""Helper functions to retrieve data from template server and broker."""

from client.documentbroker_settings import TEMPLATE_URL, BROKER_URL
from client.documentbroker_settings import CLIENT_ID, CLIENT_PASSWORD
from client.template_client import TemplateServer
from client.broker_client import DocumentBroker


def get_templates():
    ts = TemplateServer(TEMPLATE_URL)
    templates = ts.get_templates(CLIENT_ID)
    return [ (t[1], t[0]) for t in templates]

def get_template_fields(template):
    ts = TemplateServer(TEMPLATE_URL)
    return ts.get_template_fields(template)

def generate_document(template, fields):
    db = DocumentBroker(BROKER_URL)
    user_authentication = db.get_authorization(CLIENT_ID, CLIENT_PASSWORD)

    return db.generate_document(user_authentication, template, fields)
