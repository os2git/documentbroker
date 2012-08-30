from django.conf.urls import patterns, include, url

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    url(r'^demo/$', include('demo.urls')),
    url(r'^demo/show_fields/(?P<template>[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})/$', 'demo.views.show_fields'),
    # url(r'^$', 'document_broker.views.home', name='home'),
    # url(r'^document_broker/', include('document_broker.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),
    url(r'^broker-xml/$', 'django_xmlrpc.views.handle_xmlrpc')
)
