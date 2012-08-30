"""
This file contains functions and classes that help extract information from 
the template system.

"""

class TemplateData(object):
    """Represents a simple template retrieved from the template system."""
    __init__(self, name, url):
        self.name = name
        self.url = url


def get_templates(client_system):
    """Return a list of all templates available for this ClientSystem."""
    # TODO: Implement this.


def get_template_data(id, client_system):
    """Retrieve template name and URL from template server based on UUID
    supplied by client system when calling. The template system will refuse to
    supply the data if the client system does not have access to this
    template."""
    # TODO: Implement this
    return Template("None", "http://www.nowhere.org/nothing.ott")



