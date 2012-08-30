
from client.template_client import TemplateServer
from client.settings import TEMPLATE_URL

class DocumentBroker(object):
    """This class is not really a Django model. Rather, it implements a proxy
    which serves as a unified front for all the document-related functionality
    we need to support from the views. Thus, this is the "model" for the
    document broker, template retrieval and similar functionality which we need
    to handle the requests received by the views. 
    
    Whereas the view functions may be protocol dependent, this model class is
    not.
    """

    def __init__(self, user_system_id):
        self._user_system_id = user_system_id


    def generate_document(self, template_id, fields):
        """Return URL to the generated document - throw exception if not
        possible."""
        # Check user system is allowed to use template.
        ts = TemplateServer(TEMPLATE_URL)
        templates = ts.get_templates(self._user_system_id)

        if template_id in [ t[0] for t in templates]:
            # TODO: This uses name not ID, change it later.
            url = { t[0] : t[2] for t in templates }[template_id]
        else:
            url = None
        raise RuntimeError(str(templates) + url)
        # Then retrieve template from template server.
        if url:
            """ Get template file from URL. Cache? Start by retrieving
            to file buffer """
        # Finally, store template in appropriate place, generate document,
        # store document in appropriate place and return URL.
        raise RuntimeError("Not implemented: {0}".format(template_id))
        return ""

