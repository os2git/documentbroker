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

from django.contrib import admin
from django.contrib.auth.models import Group
from django.contrib.sites.models import Site

from models import Template, Field, ClientSystem


class FieldInline(admin.TabularInline):
    model = Field
    extra = 1


class TemplateAdmin(admin.ModelAdmin):
    fields = [
        'name', 'uuid', 'file', 'type', 'do_output_pdf', 'available_for',
        'version',  'status', 'url']
    readonly_fields = ['uuid', 'url', 'version']
    inlines = [FieldInline]
    list_display = ('name', 'type', 'url')


class ClientSystemAdmin(admin.ModelAdmin):
    list_display = ['name', 'client', 'description']

admin.site.register(Template, TemplateAdmin)
admin.site.register(ClientSystem, ClientSystemAdmin)

# Remove default site and group to unclutter admin interface.
admin.site.unregister(Site)
admin.site.unregister(Group)
