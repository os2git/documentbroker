
from django.contrib import admin
from django.contrib.auth.models import Group
from django.contrib.sites.models import Site

from models import Client, ClientSystem, PluginMapping

class ClientAdmin(admin.ModelAdmin):
    fields = ['name', 'description']
    list_display = ['name']


class ClientSystemAdmin(admin.ModelAdmin):
    searchfields = ['name', 'client']
    readonly_fields = ['uuid', 'user_authentication']
    list_display = ['name', 'client']

class PluginMappingAdmin(admin.ModelAdmin):
    fields = ['extension', 'plugin']
    list_display = ['extension', 'plugin']

admin.site.register(Client, ClientAdmin)
admin.site.register(ClientSystem, ClientSystemAdmin)
admin.site.register(PluginMapping, PluginMappingAdmin)


# Remove default site and group to unclutter admin interface.
admin.site.unregister(Site)
admin.site.unregister(Group)


    
