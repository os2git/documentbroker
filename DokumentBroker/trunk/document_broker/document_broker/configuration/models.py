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
import uuid
import hashlib

from django.db import models
from django.utils.translation import ugettext_lazy as _

from plugins import PluginManager
from util.helpers import get_unique_token

# Create your models here.


class Client(models.Model):
    """A short description/registration of the client for each client
    system."""
    name = models.CharField(_('Name'), max_length=255)
    description = models.TextField(_('Description'), max_length=1024)

    def __unicode__(self):
        return self.name


class ClientSystem(models.Model):
    """The client systems that are allowed to access the document broker.
    Client systems should authenticate themselves, eventually through client
    side SSL, in the proof of concept phase through a simple generated
    password/shared secret."""
    uuid = models.CharField(_('Id'),
                             max_length=36,
                             default=lambda: unicode(uuid.uuid4()),
                             editable=True, unique=True)
    name = models.CharField(_('Name'), max_length=255)
    client = models.ForeignKey(Client)
    description = models.TextField(_('Description'), max_length=1024)
    user_authentication = models.CharField(_('Authentication'),
                                           max_length=255)

    def save(self, *args, **kwargs):
        # Before save
        if len(self.user_authentication) == 0:
            self.user_authentication = get_unique_token()
        # Actual save
        super(ClientSystem, self).save(*args, **kwargs)
        # After save
        pass


class PluginMapping(models.Model):
    """This class maps from file name extensions to document plugins. This
    means we use the extensions to specify the plugin. This also mean we don't
    allow these extensions to overlap, e.g. if one soite wishes to use them in
    a non-standard way. If this ever becomes a problem, the plugin spec should
    follow the document, not the extension."""
    plugins = PluginManager.list_plugins()
    extension = models.CharField(_('Extension'), max_length=16, unique=True)
    output_type = models.CharField(_('Output Type'), max_length=16)
    plugin = models.CharField(
        _('Plugin'),
        max_length=255,
        choices=[(k, v.__doc__) for k, v in plugins.items()])

    def __unicode__(self):
        return self.extension
