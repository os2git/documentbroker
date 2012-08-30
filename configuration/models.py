import uuid
import hashlib

from django.db import models
from django.utils.translation import ugettext_lazy as _

from util.document_plugin import PluginManager

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
    uuid =  models.CharField(_('Id'),
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
            seed = unicode(uuid.uuid4())
            self.user_authentication = hashlib.sha1(seed).hexdigest()
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
    plugin = models.CharField(
            _('Plugin'), 
            max_length=255, 
            choices=[(k,v.__doc__) for k,v in plugins.items()])

    def __unicode__(self):
        return self.extension




