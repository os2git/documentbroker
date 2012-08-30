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
