# Create your views here.

# TODO: Factor out user authentication to a decorator.

from models import DocumentBroker


def generate(user_authentication, template_id, fields):
    """Gets template from template server and generates document.
    Store document in suitable place and return URL to retrieve it."""
    # TODO: CHECK USER SYSTEM IS AUTHORIZED!

    broker = DocumentBroker(user_authentication[0])

    broker.generate_document(template_id, fields)


