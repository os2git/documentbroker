import uuid
import hashlib

from django.db import models
from django.utils.translation import ugettext_lazy as _


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







