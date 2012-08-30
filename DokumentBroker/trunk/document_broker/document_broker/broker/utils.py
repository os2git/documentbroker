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

# This is a decorator to check that the user system is authorized to use
# the document broker.

from django.utils.translation import ugettext as _
from configuration.models import ClientSystem


def is_valid_login(client_id, password):
    try:
        client = ClientSystem.objects.get(uuid=client_id)
    except:
        client = None
    result = (client and client.user_authentication == password)
    return (True if result else False)


def create_authorization(client_id, password):
    """Creates an authorization block to be used by clients once they are
    logged in. In the first instance, this is just a very single pairing of
    client id and password. Later, the validation might be time-dependent and
    arbitrarily complex. The algorithm must correspond to the validation
    performed by the authorized() decorator."""
    if is_valid_login(client_id, password):
        # TODO: perform some sort of cryptographic wrapping.
        return'@'.join([client_id, password])
    else:
        return ""


def get_client_id(authorization):
    """Retrieves the client ID from an authorization block.
    TODO: This and the preceding and following functions need refactoring."""
    return authorization.split('@')[0]


def authorized(function):
    def _authorized(*args, **kw):
        # TODO: perform some sort of cryptographic UN-wrapping.
        id, pw = args[0].split('@')

        if is_valid_login(id, pw):
            return function(*args, **kw)
        else:
            raise RuntimeError(_('Authorization failed'))
    return _authorized
