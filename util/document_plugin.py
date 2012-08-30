"""This module implements all  general and non-document format specific plugin
stuff.
"""
class PluginManager(object):
    """This class groups functions and data that manipulate plugins."""
    # TODO: Consider whether this should be just functions or we really need 
    #       a manager class.
    @staticmethod
    def list_plugins():
        """List all document plugins."""
        return []

    @staticmethod
    def get_plugin(plugin_name):
        return None


class DocumentPlugin(object):
    """This is the superclass for all document plugins.

       This is an abstract superclass - all knowledge of different document 
       formats, even their names and their existence, is relegated to the 
       actual plugins.
    """

    def generate(self, template_file, output_path, fields):
        """Generate a document using the file *template_file*, place the
        resulting document in the path given by *document_path*. 
        
        Use the fields specified in the dictionary *fields* to generate the 
        document. This dictionary is a simple mapping from name  to (value,
        type).
        """
        pass
