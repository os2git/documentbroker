# Create your views here.

# TODO: Factor out user authentication to a decorator.


from models import DocumentBroker
from utils import authorized

from configuration.models import ClientSystem


def get_client_systems():
    client_systems = ClientSystem.objects.all()
    return [(c.name, c.uuid) for c in client_systems]


@authorized
def generate(user_authentication, template_id, fields):
    """Gets template from template server and generates document.
    Store document in suitable place and return URL to retrieve it."""
    # TODO: CHECK USER SYSTEM IS AUTHORIZED!

    broker = DocumentBroker(user_authentication[0])

    broker.generate_document(template_id, fields)


