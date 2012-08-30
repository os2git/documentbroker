

class DocumentPlugin(object):
    """This is the superclass for all document plugins.

       This is an abstract superclass - all knowledge of different document 
       formats, even their names and their existence, is relegated to the 
       actual plugins.
    """

    def generate_document(self, template_file, output_path, fields):
        """Generate a document using the file *template_file*, place the
        resulting document in the path given by *document_path*. 
        
        Use the fields specified in the dictionary *fields* to generate the 
        document. This dictionary is a simple mapping from name  to (value,
        type).
        """
        pass
