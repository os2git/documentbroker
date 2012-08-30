"""
This module contains a simple function which takes an input (ODF Template)
path, a list of fields and an output file path and generates the output file
from the input.

Note: Valid field types for ODF are 'boolean', 'currency', 'date', 'float',
    'percentage', 'string' and 'time'. 

"""

from datetime import datetime

from lpod import ODF_META
from lpod.document import odf_new_document_from_template

# Some special fields
MODULE_NAME = 'Magenta ODF Generator'
DOCUMENT_CREATOR = 'document_creator'

def generate_odf(template_path, fields, output_path):
    """Generate document in output_path from input_path using fields."""
    
    # Create document from template.
    document = odf_new_document_from_template(template_path)

    content = document.get_content()
    body = content.get_body()
    meta = document.get_part(ODF_META)

    # Set properties.
    meta.set_modification_date(datetime.today())
    meta.set_creation_date(datetime.today())
    meta.set_initial_creator(fields[DOCUMENT_CREATOR] if DOCUMENT_CREATOR in
                             fields else MODULE_NAME)
    meta.set_editing_cycles(1)
    meta.set_generator(MODULE_NAME)

    # Now, set field values. Ignore non-text values for now.
    type = 'string'
    for field_name, value in fields.items():
        field = body.get_user_field_decl(field_name)
        value_string = 'office:{0}-value'.format(type)

        field.set_attribute('office:value-type', type)
        field.set_attribute(value_string, value)
        field.set_attribute('office:value', value)

    # Now save document.
    #raise RuntimeError("Not implemented: {0} - {1} - {2}".format(
    #    template_path, output_path, ':'.join([value_string, value])))
    document.save(target=output_path, pretty=True)
    
    # TODO: This should be it! I imagine some book-keeping and exception
    # handling would be nice, though.


if __name__ == '__main__':
    
    # Unit test, used for interactive Ellehammer testing during development.
    import sys

    if len(sys.argv) < 2:
        print "Usage: python odf_generator.py <input_file> [<output_file>]"
        exit()

    inputfile = sys.argv[1]

    document_file = sys.argv[2] if len(sys.argv) > 2 else 'document.odf'
    
    fields = {}
    fields['Leif'] = ('Carsten Agger', 'string')
    fields['Dato'] = ('2012-05-01', 'date')
    fields['Svaret'] = ('142', 'string')

    generate_odf(inputfile, fields, document_file)

