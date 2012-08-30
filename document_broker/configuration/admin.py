# Copyright (C) 2012  Magenta ApS.
#
# Authors: Carsten Agger (carstena@magenta-aps.dk),
#          Dennis Isaksen (dennis@magenta-aps.dk),
#          Leif Lodahl (leif@magenta-aps.dk)
#
# This file is part of the Magenta Document Broker.
#
# The Magenta Document Broker is free software: you can redistribute it
# and/or modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranties of
# MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR
# PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program.  If not, see <http://www.gnu.org/licenses/>.

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
    fields = ['extension', 'output_type', 'plugin']
    list_display = ['extension', 'plugin']


admin.site.register(Client, ClientAdmin)
admin.site.register(ClientSystem, ClientSystemAdmin)
admin.site.register(PluginMapping, PluginMappingAdmin)


# Remove default site and group to unclutter admin interface.
admin.site.unregister(Site)
admin.site.unregister(Group)
