"""This module implements all  general and non-document format specific plugin
stuff.
"""

import plugins

class PluginManager(object):
    """This class groups functions and data that manipulate plugins."""
    # TODO: Consider whether this should be just functions or we really need 
    #       a manager class.
    @staticmethod
    def list_plugins():
        """List all document plugins."""
        return plugins.list_plugins()

    @staticmethod
    def get_plugin(plugin_name):
        """This is a factory method which produces a new instance of each
        plugin class. The actual plugin classes are never imported directly,
        only through the general plugins interface."""
        plugin_class = plugins.get_plugin_class(plugin_name)
        return plugin_class()
        

