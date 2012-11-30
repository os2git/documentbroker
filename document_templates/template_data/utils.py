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

from django.conf import settings
from django.utils.translation import ugettext as _

from middleware import get_current_request
from models import ClientSystem


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


def check_ssl_connection():
    """If SSL authorization is required, check that a valid connection exists
    and corresponds to the ID of an existing client."""
    if settings.SSL_AUTHENTICATION:
        client_id = get_ssl_cn()
        try:
            client = ClientSystem.objects.get(uuid=client_id)
        except:
            raise RuntimeError(_(
                'Authorization failed for client {0}'.format(client_id)))
