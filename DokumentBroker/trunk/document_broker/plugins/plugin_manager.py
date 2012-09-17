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
"""This module implements all  general and non-document format specific plugin
stuff.
"""

from ODFPlugin import ODFPlugin
from OOXMLPlugin import OOXMLPlugin
from PDFPlugin import PDFPlugin
from XHTMLPlugin import XHTMLPlugin

_plugins = [ODFPlugin, OOXMLPlugin, XHTMLPlugin]
_plugin_dict = {p.__name__: p for p in _plugins}


def _list_plugins():
    """Returns a dictionary name->class of all plugin classes"""
    return _plugin_dict


def _get_plugin_class(plugin_name):
    """Returns the class corresponding to the plugin name - not the instance.
    Raise exception if it doesn't exist - this method should ONLY be called
    with a string known to be a plugin name."""
    try:
        klass = _plugin_dict[plugin_name]
    except KeyError:
        raise RuntimeError("No such plugin: {0}".format(plugin_name))
    return klass


class PluginManager(object):
    """This class groups functions and data that manipulate plugins."""
    # TODO: Consider whether this should be just functions or we really need
    #       a manager class.
    @staticmethod
    def list_plugins():
        """List all document plugins.
        Returns a dictionary name->class of all plugin classes"""
        return _list_plugins()

    @staticmethod
    def get_plugin(plugin_name):
        """This is a factory method which produces a new instance of each
        plugin class. The actual plugin classes are never imported directly,
        only through the general plugins interface."""
        plugin_class = _get_plugin_class(plugin_name)
        return plugin_class()
