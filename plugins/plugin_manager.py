"""This module implements all  general and non-document format specific plugin
stuff.
"""

from ODFPlugin import ODFPlugin
from OOXMLPlugin import OOXMLPlugin
from PDFPlugin import PDFPlugin

_plugins = [ODFPlugin, OOXMLPlugin, PDFPlugin]
_plugin_dict = { p.__name__ : p for p in _plugins }

def _list_plugins():
    """Returns a dictionary name->class of all plugin classes"""
    return _plugin_dict

def _get_plugin_class(plugin_name):
    """Returns the class corresponding to the plugin name - not the instance.
    Raise exception if it doesn't exist - this method should ONLY be called 
    with a string known to be a plugin name."""
    try:
        klass =  _plugin_dict[plugin_name]
    except KeyError:
        raise RuntimeException("No such plugin: {0}".format(plugin_name))
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
        

