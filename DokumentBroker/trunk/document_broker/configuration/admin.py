
from django.contrib import admin

from models import Client, ClientSystem

class ClientAdmin(admin.ModelAdmin):
    fields = ['name', 'description']
    list_display = ['name']


class ClientSystemAdmin(admin.ModelAdmin):
    searchfields = ['name', 'client']
    readonly_fields = ['uuid', 'user_authentication']
    list_display = ['name', 'client']

admin.site.register(Client, ClientAdmin)
admin.site.register(ClientSystem, ClientSystemAdmin)

    
