

from ODFPlugin import ODFPlugin
from OOXMLPlugin import OOXMLPlugin
from PDFPlugin import PDFPlugin

_plugins = [ODFPlugin, OOXMLPlugin, PDFPlugin]
_plugin_dict = { p.__name__ : p for p in _plugins }

def list_plugins():
    """Returns a dictionary name->class of all plugin classes"""
    return _plugin_dict

def get_plugin_class(plugin_name):
    """Returns the class corresponding to the plugin name - not the instance.
    Raise exception if it doesn't exist - this method should ONLY be called with a
    string known to be a plugin name."""
    try:
        klass =  _plugin_dict[plugin_name]
    except KeyError:
        raise RuntimeException("No such plugin: {0}".format(plugin_name))
    return klass

