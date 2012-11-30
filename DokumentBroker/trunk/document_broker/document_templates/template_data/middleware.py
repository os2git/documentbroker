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

import threading
_thread_locals = threading.local()


def get_current_request():
    return getattr(_thread_locals, 'request', None)


class ThreadLocals(object):
    """
    Middleware that gets various objects from the
    request object and saves them in thread local storage.
    """
    def process_request(self, request):
        _thread_locals.request = request
