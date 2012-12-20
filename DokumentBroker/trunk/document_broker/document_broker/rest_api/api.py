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
"""
This is the module that maps the REST API to the broker methods.
"""

from tastypie.resources import Resource
from tastypie import fields
from broker.models import DocumentBroker
from configuration.models import ClientSystem
from tastypie.authentication import Authentication
from tastypie.authorization import Authorization
from broker.views import (generate_document, get_client_systems,
get_plugin_mappings, acknowledge_document, generate_preview, get_authorization)
from broker.utils import create_authorization
from client import document_broker_settings as settings
from django.conf.urls import url


class ContainerObject(object):
    """
    This is a container class for our resource data. The class acts as a
    generic container for all resources.
    """
    def __init__(self, initial=None):
        self.__dict__['_data'] = {}

        if hasattr(initial, 'items'):
            self.__dict__['_data'] = initial

    def __getattr__(self, name):
        return self._data.get(name, None)

    def __setattr__(self, name, value):
        self.__dict__['_data'][name] = value

    def to_dict(self):
        return self._data


class AuthorizationResource(Resource):
    """
    This class acts as a REST wrapper for the get_authorization method.
    It takes two parameters:
    client_id and password.
    It returns an authentication token
    """

    """
    The fields to be returned on document generation.
    """
    token = fields.CharField(
        attribute='token',
        help_text='The authentication token',
        null=True
    )

    class Meta:
        # OBS!
        # No authorization is done at this stage.
        authentication = Authentication()
        authorization = Authorization()

        """
        This is the name of the resource, which we will call in the URI.
        """
        resource_name = 'get_authorization'

        """
        We only support the HTTP POST method as this is a sort of create
        operation.
        """
        allowed_methods = ['post']

        """
        We always return the authentication token to the caller. This is not
        the default behaviour of POST.
        """
        always_return_data = True

        """
        We need to tie data up in this object.
        """
        object_class = ContainerObject

        """
        The resource uri is not useful in our case.
        """
        include_resource_uri = False

    def obj_create(self, bundle, request=None, **kwargs):
        # OBS!
        # This is only for debugging. In production authentication should be
        # carried out.
        """
        We check for data in the url and in the submitted data.
        """
        if 'client_id' in bundle.data:
            client_id = bundle.data['client_id']
            del bundle.data["client_id"]
        else:
            client_id = request.POST['client_id']
        if 'password' in bundle.data:
            password = bundle.data['password']
            del bundle.data["password"]
        else:
            password = request.POST['password']

        token = get_authorization(
            client_id,
            password
        )
        """ We create an object to hold our data """
        data_obj = ContainerObject()
        data_obj.__setattr__("token", token)
        bundle.obj = data_obj
        return bundle

    def get_resource_uri(self, bundle):
        pass


class GenerateDocumentResource(Resource):
    """
    This class acts as a REST wrapper for the generate_document method.
    It takes three parameters:
    authentication, template_id and (optionally) field_data.
    It returns two values:
    url and hash_key.
    """

    """
    The fields to be returned on document generation.
    """
    url = fields.CharField(
        attribute='url',
        help_text='URL to the generated document',
        null=True
    )
    hash_key = fields.CharField(
        attribute='hash_key',
        help_text='Hash value of the generated document',
        null=True
    )

    """
    Variables to hold the response data.
    """
    _url = ""

    class Meta:
        # OBS!
        # No authorization is done at this stage.
        authentication = Authentication()
        authorization = Authorization()

        """
        This is the name of the resource, which we will call in the URI.
        """
        resource_name = 'generate_document'

        """
        We only support the HTTP POST method as this is a sort of create
        operation.
        """
        allowed_methods = ['post']

        """
        We always return the URL and hash key to the caller. This is not the
        default behaviour of POST.
        """
        always_return_data = True

        """
        We need to tie data up in this object.
        """
        object_class = ContainerObject

        """
        The resource uri is not useful in our case.
        """
        include_resource_uri = False

    """
    This is for PUT requests, but should not be necessary.
    def prepend_urls(self):
        return [
            url(r"^(?P<resource_name>%s)/(?P<authentication>[a-f0-9]{8}-"
            "[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}@[a-f0-9]{40})/"
            "(?P<template_id>[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-"
            "[a-f0-9]{12})/(?P<field_data>.+)/$" % self._meta.resource_name,
            self.wrap_view('dispatch_detail'),
            name="api_dispatch_detail"
            ),
        ]

    def override_urls(self):
        return self.prepend_urls()
    """

    def obj_create(self, bundle, request=None, **kwargs):
        # OBS!
        # This is only for debugging. In production authentication should be
        # carried out.
        """
        We check for data in the url and in the submitted data.
        """
        if 'authentication' in bundle.data:
            authentication = bundle.data['authentication']
            del bundle.data["authentication"]
        else:
            authentication = request.POST['authentication']
        if 'template_id' in bundle.data:
            template_id = bundle.data['template_id']
            del bundle.data["template_id"]
        else:
            template_id = request.POST['template_id']
        if 'field_data' in bundle.data:
            field_data = bundle.data['field_data']
            del bundle.data["field_data"]
        else:
            field_data = request.POST['field_data']
        """
        # For demo purpose we authenticate via the debug settings
        authentication = create_authorization(
            settings.CLIENT_ID,
            settings.CLIENT_PASSWORD
        )
        """
        """
        If we recieve no field data we create a new empty list as the method
        does not accept None values.
        """
        if field_data is None or field_data == "null":
            field_data = {"": ""}
        (self._url, self._hash_key) = generate_document(
            authentication,
            template_id,
            field_data['items']
        )
        """ We create an object to hold our data """
        data_obj = ContainerObject()
        data_obj.__setattr__("url", self._url)
        data_obj.__setattr__("hash_key", self._hash_key)
        bundle.obj = data_obj
        return bundle

    """
    This is for PUT requests, but should not be necessary.
    def obj_update(self, bundle, request=None, **kwargs):
        return self.obj_create(bundle, request, **kwargs)
    """

    def get_resource_uri(self, bundle):
        """
        Instead of returning a REST URL in the response headers location field
        we return the URL to the document.
        """
        return self._url


class ClientSystemsResource(Resource):
    """
    This class acts as a REST wrapper for the get_client_systems method.
    It takes one parameter:
    authentication
    It returns a list of systems
    """

    """ The fields required for this resource. """
    systems = fields.DictField(
        attribute='systems',
        help_text='The sytems available for this client',
        null=True
    )

    class Meta:
        # OBS!
        # No authorization is done at this stage.
        authentication = Authentication()
        authorization = Authorization()

        """
        This is the name of the resource, which we will call in the URI.
        """
        resource_name = 'get_client_systems'

        """
        We only support the HTTP GET method.
        """
        allowed_methods = ['get']

        """
        We need to tie data up in this object.
        """
        object_class = ContainerObject

        """
        The resource uri is not useful in our case.
        """
        include_resource_uri = False

    def prepend_urls(self):
        """
        Since we are not using one of the tastypie standard url patterns we
        must specify our own.
        """

        """
        This method is not add before version 1.0, so until then we just call
        it from override_urls which will be deprecated at that time.
        """
        return [
            url(r"^(?P<resource_name>%s)/(?P<authentication>[a-f0-9]{8}-"
            "[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}"
            "@[a-f0-9]{40})/$" % self._meta.resource_name,
            self.wrap_view('dispatch_detail'),
            name="api_dispatch_detail"
            ),
        ]

    def override_urls(self):
        """
        This method is deprecated as of version 1.0 and thus we do this
        workaround because the prepend_urls method will not be added before
        version 1.0.
        """
        return self.prepend_urls()

    def get_object_list(self, request):
        """
        We will not allow list look-ups.
        """
        pass

    def obj_get_list(self, request=None, **kwargs):
        """
        We will not allow list look-ups.
        """
        pass

    def obj_get(self, request=None, **kwargs):
        """
        This is where we return the data.
        """
        data_obj = ContainerObject()
        """ We grab the authentication... """
        if 'pk' in kwargs:
            authentication = kwargs['pk']
        elif 'authentication' in request.GET:
            authentication = request.GET['authentication']
        """ ... and extract the client systems: """
        client_systems = get_client_systems(authentication)
        data = []
        print "TEST"
        keys = client_systems.keys()
        #print "KEYS: " + str(keys)
        index = 0
        for key in keys:
            item = {
                "name": key.encode('utf-8'),
                "uuid": client_systems[key].encode('utf-8')
            }
            data.append(("item" + str(index),   item))
            index += 1
        data_obj.__setattr__("systems", dict(data))
        return data_obj


class PluginMappingsResource(Resource):
    """
    This class acts as a REST wrapper for the get_plugin_mappings method.
    It takes no parameters:
    It returns a list of plugins.
    """

    """ The fields required for this resource. """
    plugins = fields.DictField(
        attribute='plugins',
        help_text='The list of plugins',
        null=True
    )

    class Meta:
        # OBS!
        # No authorization is done at this stage.
        authentication = Authentication()
        authorization = Authorization()

        """
        This is the name of the resource, which we will call in the URI.
        """
        resource_name = 'get_plugin_mappings'

        """
        We only support the HTTP GET method.
        """
        allowed_methods = ['get']

        """
        The resource uri is not useful in our case.
        """
        include_resource_uri = False

    def get_object_list(self, request):
        """
        We will only respond to non-specific request as this is a list method.
        """
        plugins = get_plugin_mappings()
        keys = plugins.keys()
        items = []
        data = []
        index = 0
        for key in keys:
            item = {
                'extension': key,
                'plugin': plugins[key]
            }
            items.append(("item" + str(index),   item))
            index += 1
        data_obj = ContainerObject()
        data_obj.__setattr__("plugins", dict(items))
        data.append(data_obj)
        return data

    def obj_get_list(self, request=None, **kwargs):
        """
        We will only respond to non-specific request as this is a list method.
        """
        return self.get_object_list(request)

    def alter_list_data_to_serialize(self, request, data):
        """
        We do all these changes to get a homogenious data format. By default
        tastypie adds a meta object to the data and wraps it all in a response
        object. That is not done in the single object calls, so to meet the
        same format we get rid of these additional objects.
        """
        if isinstance(data, dict):
            if 'meta' in data:
                del data['meta']
            data = data['objects'][0]
            print "DATA: " + str(data)
        return data


class AcknowledgeDocumentResource(Resource):
    """
    This class acts as a REST wrapper for the acknowledge_document method.
    It takes two parameters:
    authentication, document
    It returns nothing but a HTTP status.
    """

    class Meta:
        # OBS!
        # No authorization is done at this stage.
        authentication = Authentication()
        authorization = Authorization()

        """
        This is the name of the resource, which we will call in the URI.
        """
        resource_name = 'acknowledge_document'

        """
        Apparently we need to tie it all up in an object.
        """
        object_class = ContainerObject

        """
        We only support the HTTP DELETE method.
        """
        allowed_methods = ['delete']

    def prepend_urls(self):
        """
        Since we are not using one of the tastypie standard url patterns we
        must specify our own.
        """

        """
        This method is not add before version 1.0, so until then we just call
        it from override_urls which will be deprecated at that time.
        """
        return [
            url(r"^(?P<resource_name>%s)/(?P<authentication>[a-f0-9]{8}-"
            "[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}@[a-f0-9]{40})/"
            "(?P<document>.+)/$" % self._meta.resource_name,
            self.wrap_view('dispatch_detail'),
            name="api_dispatch_detail"
            ),
        ]

    def override_urls(self):
        """
        This method is deprecated as of version 1.0 and thus we do this
        workaround because the prepend_urls method will not be added before
        version 1.0.
        """
        return self.prepend_urls()

    def obj_delete_list(self, request=None, **kwargs):
        """ We don't allow deleting rows of documents only specific ones. """
        pass

    def obj_delete(self, request=None, **kwargs):
        """
        The delete method does not allow us to send data along, so we just
        fetch the data from the URL:
        """
        authentication = kwargs['authentication']
        document = kwargs['document']
        print "DOCUMENT: " + document
        """
        And finally we pass them to the acknowledge_document method:
        """
        acknowledge_document(authentication, document)


class PreviewResource(Resource):
    """
    This class acts as a REST wrapper for the generate_preview method.
    It takes five parameters:
    authentication, template_id, field_data, return_format and resolution
    It returns:
    url and hash_key.
    """

    url = fields.CharField(
        attribute='url',
        help_text='URL to the generated document',
        null=True
    )
    hash_key = fields.CharField(
        attribute='hash_key',
        help_text='Hash value of the generated document',
        null=True
    )

    """
    Variables to hold the response data.
    """
    _url = ""

    class Meta:
        # OBS!
        # No authorization is done at this stage.
        authentication = Authentication()
        authorization = Authorization()

        """
        This is the name of the resource, which we will call in the URI.
        """
        resource_name = 'generate_preview'

        """
        We only support the HTTP POST method.
        """
        allowed_methods = ['post']

        """
        We always return the URL to the caller. This is not the default
        behaviour of POST.
        """
        always_return_data = True

        """
        Apparently we need to tie it all up in an object.
        """
        object_class = ContainerObject

        """
        The resource uri is not useful in our case.
        """
        include_resource_uri = False

    """
    This is for PUT requests, but should not be necessary.
    def prepend_urls(self):
        return [
            url(r"^(?P<resource_name>%s)/(?P<authentication>[a-f0-9]{8}-"
            "[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}@[a-f0-9]{40})/"
            "(?P<template_id>[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-"
            "[a-f0-9]{12})/(?P<field_data>.+)/(?P<return_format>.+)/"
            "(?P<resolusion>.+)/$" % self._meta.resource_name,
            self.wrap_view('dispatch_detail'),
            name="api_dispatch_detail"
            ),
        ]

    def override_urls(self):
        return self.prepend_urls()
    """

    def obj_create(self, bundle, request=None, **kwargs):
        # OBS!
        # This is only for debugging. In production authentication should be
        # carried out.
        """
        We check for data in the url.
        """
        if "authentication" in request.POST:
            authentication = request.POST['authentication']
        else:
            authentication = bundle.data['authentication']
            del bundle.data['authentication']
        if "template_id" in request.POST:
            template_id = request.POST['template_id']
        else:
            template_id = bundle.data['template_id']
            del bundle.data['template_id']
        if "field_data" in request.POST:
            field_data = request.POST['field_data']
        else:
            field_data = bundle.data['field_data']
            del bundle.data['field_data']
        if "return_format" in request.POST:
            return_format = request.POST['return_format']
        else:
            return_format = bundle.data['return_format']
            del bundle.data['return_format']
        if "resolusion" in request.POST:
            resolusion = request.POST['resolusion']
        else:
            resolusion = bundle.data['resolusion']
            del bundle.data['resolusion']
        """
        authentication = create_authorization(
            settings.CLIENT_ID,
            settings.CLIENT_PASSWORD
        )
        """
        """
        If we recieve no field data we create a new empty list as the method
        does not accept None values.
        """
        if field_data is None or field_data == "null":
            field_data = {"": ""}
        (self._url, hash_key) = generate_preview(
            authentication,
            template_id,
            field_data['items'],
            return_format,
            resolusion
        )
        data_obj = ContainerObject()
        data_obj.__setattr__("url", self._url)
        data_obj.__setattr__("hash_key", hash_key)
        bundle.obj = data_obj
        return bundle

    """
    This is for PUT requests, but should not be necessary.
    def obj_update(self, bundle, request=None, **kwargs):
        return self.obj_create(bundle, request, **kwargs)
    """

    def get_resource_uri(self, bundle):
        """
        Instead of returning a REST URL in the response headers location field
        we return the URL to the document.
        """
        return self._url
