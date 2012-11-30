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

import os

from django.conf import settings
from django.conf.urls import patterns, include, url
from util.helpers import get_install_dir
from tastypie.api import Api
from rest_api import templates_api as rest_api

# Enable admin:
from django.contrib import admin
admin.autodiscover()

api_test = Api(api_name='test')
api_test.register(rest_api.TemplatesResource())
api_test.register(rest_api.TemplatesFieldsResource())
api_test.register(rest_api.PrecompiledTemplateResource())
api_test.register(rest_api.ThumbnailResource())
api_test.register(rest_api.ExampleResource())

urlpatterns = patterns(
    '',
    # Examples:
    # url(r'^$', 'document_templates.views.home', name='home'),
    # url(r'^document_templates/', include('document_templates.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),
    url(r'^billeder/', include('photologue.urls')),
    url(r'^template-xml/$', 'django_xmlrpc.views.handle_xmlrpc'),
    # REST examples:
    (r'^rest_api/', include(api_test.urls),
    )
)

if settings.DEBUG:
    urlpatterns += patterns(
        'django.views.static',
        (r'media/(?P<path>.*)', 'serve',
            {'document_root': settings.MEDIA_ROOT}),
    )
