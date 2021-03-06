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
"""This package implements the document broker plugin system.
The PluginManager class is the ONLY public interface.

To implement a new plugin, subclass from the DocumentPlugin superclass and add
it to the list "_plugins" in plugin_manager.py.
"""
from plugin_manager import PluginManager
"""
The PluginManager class should not be instantiated, but contains two static
methods:
 |  get_plugin(plugin_name)
 |      This is a factory method which produces a new instance of each
 |      plugin class. The actual plugin classes are never imported directly,
 |      only through the general plugins interface.
 |
 |  list_plugins()
 |      List all document plugins.
 |      Returns a dictionary name->class of all plugin classes.
"""
