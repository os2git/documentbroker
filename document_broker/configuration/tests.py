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
"""
This file demonstrates writing tests using the unittest module. These will pass
when you run "manage.py test".

Replace this with more appropriate tests for your application.
"""


import pep8

from django.test import TestCase
from django.conf import settings

from client.broker_client import test as broker_test


class SimpleTest(TestCase):
    def test_basic_addition(self):
        """
        Tests that 1 + 1 always equals 2.
        """
        self.assertEqual(1 + 1, 2)


class Pep8Test(TestCase):
    def test_pep8(self):
        filepath = settings.INSTALL_DIR
        arglist = ['--exclude=', filepath]
        pep8.process_options(arglist)
        pep8.input_dir(filepath)
        output = pep8.get_statistics()
        self.assertEqual(len(output), 0)


class ClientTest(TestCase):
    """This runs the simple broker client test. Please note that this
    test requires the broker and templates servers specified in the
    client configuration to be up and running, and preferrably on the
    same server as in that case we're testing the same code."""

    def test_client(self):
        rc = broker_test()
        self.assertEqual(rc, 0)
