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
