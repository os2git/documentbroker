
from django.conf.urls import patterns, url


urlpatterns = patterns('',
        # Main demo site
        url(r'^$', 'demo.views.select_template', name='select_template'),
        url(r'^show_fields/$', 'demo.views.show_fields', name='show_fields'),
)
