
# This is a decorator to check that the user system is authorized to use 
# the document broker.

from django.utils.translation import ugettext as _
from configuration.models import ClientSystem

def authorized(function):
    def _authorized(*args, **kw):
        id, pw = args[0]
        try:
            client = ClientSystem.objects.get(uuid=id)
        except: 
            client = None

        if client and client.user_authentication == pw:
            return function(*args, **kw)
        else:
            raise RuntimeError(_('Authorization failed'))
    return _authorized


