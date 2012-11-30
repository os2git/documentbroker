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

from django.conf.urls import patterns, include, url
from tastypie.api import Api
from rest_api import api as rest_api

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

api_test = Api(api_name='test')
api_test.register(rest_api.GenerateDocumentResource())
api_test.register(rest_api.ClientSystemsResource())
api_test.register(rest_api.AuthorizationResource())
api_test.register(rest_api.PluginMappingsResource())
api_test.register(rest_api.AcknowledgeDocumentResource())
api_test.register(rest_api.PreviewResource())

urlpatterns = patterns(
    '',
    # Examples:
    url(r'^demo/$', include('demo.urls')),
    url(r'^demo/show_fields/(?P<template>' +
        '[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})/$',
        'demo.views.show_fields'),
    # url(r'^$', 'document_broker.views.home', name='home'),
    # url(r'^document_broker/', include('document_broker.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),
    url(r'^broker-xml/$', 'django_xmlrpc.views.handle_xmlrpc'),
    # REST examples:
    (r'^rest_api/', include(api_test.urls)
    )
)
