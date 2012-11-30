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


import os
import pep8

from django.test import TestCase
from django.conf import settings


class SimpleTest(TestCase):
    def test_basic_addition(self):
        """
        Tests that 1 + 1 always equals 2.
        """
        self.assertEqual(1 + 1, 2)


def pep8_test(filepath):
    def do_test(self):
        arglist = ['--exclude=', filepath]
        pep8.process_options(arglist)
        pep8.input_dir(filepath)
        output = pep8.get_statistics()
        print "PEP8 OUTPUT: " + str(output)
        self.assertEqual(len(output), 0)

    return do_test


class Pep8Test(TestCase):
    """Test that the template system a well as the default clients and plugins
    are PEP8-compliant."""
    test_pep8 = pep8_test(settings.INSTALL_DIR)
    test_plugins = pep8_test(os.path.join(settings.INSTALL_DIR, 'plugins'))
    test_client = pep8_test(os.path.join(settings.INSTALL_DIR, 'client'))
