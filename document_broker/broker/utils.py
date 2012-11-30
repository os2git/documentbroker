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

# This is a decorator to check that the user system is authorized to use
# the document broker.

import hashlib

from django.utils.translation import ugettext as _
from django.conf import settings

from configuration.models import ClientSystem
from middleware import get_current_request


def sha1_hash(s):
    """Compute SHA1 hash from string"""
    sha = hashlib.sha1()
    sha.update(s)
    return sha.hexdigest()


def get_ssl_cn():
    # Get the Common Name of the SSL client certificate.
    # If there's no CN, there is no valid client SSL certificate
    # and SSL authorization cannot be used.
    # In that case, throw an exception - this should only be used
    # if SSL is set up properly
    http_request = get_current_request()
    try:
        cn = http_request.META['SSL_CLIENT_S_DN_CN']
        return cn
    except KeyError:
        raise RuntimeError(
            _('SSL configuration error: No client certificate'))


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
    if settings.SSL_AUTHENTICATION:
        """Check there is a valid client certificate, and check that this
        client certificate corresponds to a registered client system."""
        client_id = get_ssl_cn()
        try:
            client = ClientSystem.objects.get(uuid=client_id)
        except:
            client = None
        if client:
            return sha1_hash(client.uuid)
        else:
            return ""
    else:
        if is_valid_login(client_id, password):
            # TODO: perform some sort of cryptographic wrapping.
            return'@'.join([client_id, password])
        else:
            return ""


def get_client_id(authorization):
    """Retrieves the client ID from an authorization block.
    TODO: This and the preceding and following functions need refactoring."""
    if settings.SSL_AUTHENTICATION:
        client_id = get_ssl_cn()
        # Invariant, since this will only be called in authorized function
        # call.
        assert(authorization == sha1_hash(client_id))
        return client_id
    else:
        return authorization.split('@')[0]


def authorized(function):
    def _authorized(*args, **kw):
        # TODO: perform some sort of cryptographic UN-wrapping.
        if settings.SSL_AUTHENTICATION:
            # SSL Authentication is on.
            # This will only work if Apache is configured correctly,
            # and the client has presented a valid certificate recognized
            # by the server's CA.
            http_request = get_current_request()

            client_id = get_ssl_cn()
            auth_code = args[0]
            if sha1_hash(client_id) == auth_code:
                return function(*args, **kw)
            else:
                raise RuntimeError(_('Authorization failed'))
        else:
            # No SSL, simple password validation
            id, pw = args[0].split('@')

            if is_valid_login(id, pw):
                return function(*args, **kw)
            else:
                raise RuntimeError(_('Authorization failed'))
    return _authorized
