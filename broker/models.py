
import os
import urllib

from django.conf import settings 

from client.template_client import TemplateServer
from client.documentbroker_settings import TEMPLATE_URL, TEMPLATE_BASE_URL
from client.documentbroker_settings import BROKER_BASE_URL
from configuration.models import PluginMapping
from plugins import PluginManager
from util.helpers import get_unique_token

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

    def generate_document(self, template_id, field_data):
        """Return URL to the generated document - throw exception if not
        possible."""
        # Check user system is allowed to use template.
        ts = TemplateServer(TEMPLATE_URL)
        templates = ts.get_templates(self._user_system_id)
        template_dict = { t[1] : t[2] for t in templates } 

        try:
            url = template_dict[template_id]
        except KeyError:
            url = None
            raise RuntimeError(
                    'Template {0} not available for client.'.format(
                        template_id)
                    )
        # Retrieve template from template server.
        real_url = TEMPLATE_BASE_URL + url
        file_base, extension = os.path.splitext(url)
        file_base = file_base.split('/').pop()
        tmp_name = '/tmp/{0}{1}'.format(template_id, extension)
        (fn , headers) = urllib.urlretrieve(real_url, tmp_name)

        # Finally generate document, store in appropriate place and 
        # return URL.

        # Get plugin.
        plugin_mapping = PluginMapping.objects.filter(
                extension=extension.strip('.').upper()
                )[0]
        plugin = PluginManager.get_plugin(plugin_mapping.plugin)

        # Get fields from template system
        fields = ts.get_template_fields(template_id)
        # Get output file name
        unique_url = get_unique_token()
        output_dir = os.path.join(settings.MEDIA_ROOT, 'files') 
        output_file = '.'.join([unique_url, plugin_mapping.output_type])
        output_path = os.path.join(output_dir, output_file)
        # TODO: Implement indirect URL scheme instead of exposing file
        # location.
        # TODO: Validate that fields in call exist in template, etc.
        output_url = settings.MEDIA_URL + 'files/' + output_file
        #raise RuntimeError("Not implemented: {0}".format(output_url))
        plugin.generate_document(tmp_name, output_path, field_data)

        return BROKER_BASE_URL + output_url

    def acknowledge_document(self, document_url):
        file_name = document_url.split('/').pop()
        file_path = os.path.join(settings.MEDIA_ROOT, 
                os.path.join('files', file_name))
        try:
            os.remove(file_path)
        except OSError:
            # TODO: Log this.
            pass
        return 0


