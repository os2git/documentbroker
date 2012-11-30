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
This is the module that maps the REST API to the template server methods.
"""

from tastypie.resources import Resource
from tastypie import fields
from tastypie.authentication import Authentication
from tastypie.authorization import Authorization
from template_data.views import (get_templates, get_template_fields,
get_template, get_thumbnail_image, get_example_image)
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


class TemplatesResource(Resource):
    """
    This class acts as a REST wrapper for the get_templates method.
    It takes one parameter:
    system_id
    It returns a list of templates available for the given system.
    """

    """ The fields required for this resource. """
    templates = fields.DictField(
        attribute='templates',
        help_text='The templates to be returned'
    )

    class Meta:
        # OBS!
        # No authorization is done at this stage.
        authentication = Authentication()
        authorization = Authorization()

        """
        This is the name of the resource, which we will call in the URI.
        """
        resource_name = 'get_templates'

        """
        We only support the HTTP GET method.
        """
        allowed_methods = ['get']

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
            url(r"^(?P<resource_name>%s)/(?P<system_id>[a-f0-9]{8}-[a-f0-9]{4}"
                "-[a-f0-9]{4}-[a-f0-9]{4}"
                "-[a-f0-9]{12})/$" % self._meta.resource_name,
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
        We will only respond to non-specific request as this is a list method.
        """
        data_obj = ContainerObject()
        data = []
        if 'system_id' in kwargs:
            sys_id = kwargs['system_id']
        else:
            sys_id = request.GET['system_id']
        templates = get_templates(sys_id)
        index = 0
        for fields in templates:
            item = {
                    "name": fields[0],
                    "uuid": fields[1],
                    "file": fields[2],
                    "pdf": fields[3],
                    "thumb": fields[4]
                }
            data.append(("item" + str(index),   item))
            index += 1
        data_obj.__setattr__('templates', dict(data))
        return data_obj


class TemplatesFieldsResource(Resource):
    """
    This class acts as a REST wrapper for the get_template_fields method.
    It takes one parameter:
    template_id
    It returns a list af fields from the given template.
    """

    """ The fields required for this resource. """
    fields = fields.ListField(
        attribute='fields',
        help_text='The list of fields contained in the requested template'
    )

    class Meta:
        # OBS!
        # No authorization is done at this stage.
        authentication = Authentication()
        authorization = Authorization()

        """
        This is the name of the resource, which we will call in the URI.
        """
        resource_name = 'get_template_fields'

        """
        We only support the HTTP GET method.
        """
        allowed_methods = ['get']

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
            url(r"^(?P<resource_name>%s)/(?P<template_id>[a-f0-9]{8}-[a-f0-9]"
                "{4}-[a-f0-9]{4}-[a-f0-9]"
                "{4}-[a-f0-9]{12})/$" % self._meta.resource_name,
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
        We will only respond to non-specific request as this is a list method.
        """
        data_obj = ContainerObject()
        if 'template_id' in kwargs:
            tmp_id = kwargs['template_id']
        else:
            tmp_id = request.GET['template_id']
        data_obj.__setattr__('template_id', tmp_id)
        data = []
        fields = get_template_fields(tmp_id)
        for field in fields:
            data.append(field)
        data_obj.__setattr__('fields', data)
        return data_obj


class PrecompiledTemplateResource(Resource):
    """
    This class acts as a REST wrapper for the get_template method.
    It takes two parameters:
    system_id, template_id
    It returns:
    url and do_pdf.
    """

    """ The fields required for this resource. """
    do_pdf = fields.BooleanField(
        attribute='do_pdf',
        help_text='The id of the template to load'
    )
    url = fields.CharField(
        attribute='url',
        help_text='The id of the template to load'
    )

    class Meta:
        # OBS!
        # No authorization is done at this stage.
        authentication = Authentication()
        authorization = Authorization()

        """
        This is the name of the resource, which we will call in the URI.
        """
        resource_name = 'get_template'

        """
        We only support the HTTP DELETE method.
        """
        allowed_methods = ['get']

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
            url(r"^(?P<resource_name>%s)/(?P<system_id>[a-f0-9]{8}-[a-f0-9]"
                "{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})/(?P<template_id>"
                "[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}"
                "-[a-f0-9]{12})/$" % self._meta.resource_name,
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
        We will only respond to non-specific request as this is a list method.
        """
        data_obj = ContainerObject()
        if 'system_id' in kwargs:
            sys_id = kwargs['system_id']
        else:
            sys_id = request.GET['system_id']
        if 'template_id' in kwargs:
            tmp_id = kwargs['template_id']
        else:
            tmp_id = request.GET['template_id']
        (url, do_pdf) = get_template(sys_id, tmp_id)
        data_obj.__setattr__('url', url)
        data_obj.__setattr__('do_pdf', do_pdf)
        """
        We have to return something in the method, so we return the data even
        though it is not being used...
        """
        return data_obj


class ThumbnailResource(Resource):
    """
    This class acts as a REST wrapper for the get_thumbnail_image method.
    It takes two parameters:
    system_id, template_id
    It returns:
    url.
    """

    """ The fields required for this resource. """
    url = fields.CharField(
        attribute='url',
        help_text='The URL of the image'
    )

    class Meta:
        # OBS!
        # No authorization is done at this stage.
        authentication = Authentication()
        authorization = Authorization()

        """
        This is the name of the resource, which we will call in the URI.
        """
        resource_name = 'get_thumbnail_image'

        """
        We only support the HTTP GET method.
        """
        allowed_methods = ['get']

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
            url(r"^(?P<resource_name>%s)/(?P<template_id>"
                "[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}"
                "-[a-f0-9]{12})/$" % self._meta.resource_name,
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
        We will only respond to non-specific request as this is a list method.
        """
        data_obj = ContainerObject()
        if 'template_id' in kwargs:
            tmp_id = kwargs['template_id']
        else:
            tmp_id = request.GET['template_id']
        url = get_thumbnail_image(tmp_id)
        data_obj.__setattr__('url', url)
        """
        We have to return something in the method, so we return the data even
        though it is not being used...
        """
        return data_obj


class ExampleResource(Resource):
    """
    This class acts as a REST wrapper for the get_example_image method.
    It takes two parameters:
    system_id, template_id
    It returns:
    url.
    """

    """ The fields required for this resource. """
    url = fields.CharField(
        attribute='url',
        help_text='The URL of the image'
    )

    class Meta:
        # OBS!
        # No authorization is done at this stage.
        authentication = Authentication()
        authorization = Authorization()

        """
        This is the name of the resource, which we will call in the URI.
        """
        resource_name = 'get_example_image'

        """
        We only support the HTTP GET method.
        """
        allowed_methods = ['get']

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
            url(r"^(?P<resource_name>%s)/(?P<template_id>"
                "[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}"
                "-[a-f0-9]{12})/$" % self._meta.resource_name,
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
        We will only respond to non-specific request as this is a list method.
        """
        data_obj = ContainerObject()
        if 'template_id' in kwargs:
            tmp_id = kwargs['template_id']
        else:
            tmp_id = request.GET['template_id']
        url = get_example_image(tmp_id)
        data_obj.__setattr__('url', url)
        """
        We have to return something in the method, so we return the data even
        though it is not being used...
        """
        return data_obj
