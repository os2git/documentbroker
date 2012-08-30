#!/usr/bin/env python
# -*- coding: UTF-8 -*-
"""Test program by Leif Lodahl to show the capabilities of the
LPOD library."""

from datetime import datetime

from lpod import __version__, ODF_META
from lpod.document import odf_new_document_from_template
from lpod.datatype import Date, DateTime
from lpod.variable import odf_create_user_field_get
#from lpod.element import get_user_field_decl
#lpod.element.odf_element method get_user_field_decl


# Defining paths and files
templatepath = './Test.ott'
documentpath = './Test.odt'

# Create the document object
document = odf_new_document_from_template(templatepath)
content = document.get_content()
body = content.get_body()
meta=document.get_part(ODF_META)

# Set meta values
meta.set_modification_date(datetime.today())
meta.set_creation_date(datetime.today())
meta.set_initial_creator("creator")
meta.set_editing_cycles(1)
meta.set_generator("Python")


# Set the field contents...(To be done)
fields = body.get_user_field_decl_list()
print
print "The list: "
print fields
print
print "The list has " + str(len(fields)) + " elements"
print



for item in fields:
	print
	print "The field: "
	print item
	print
	print item.get_attributes()
	print item.get_attribute("office:value")
	print item.get_attribute("office:string-value")
	print item.get_attribute("office:value-type")
	print item.get_attribute("text:name")



#	print "The value: "
#	print body.get_user_field_value("Leif")
print
print "Done"

body.get_user_field_decl("Leif").set_attribute("office:string-value", 
                                               "Carsten Agger")
body.get_user_field_decl("Dato").set_attribute("office:value-type", "date")
body.get_user_field_decl("Dato").set_attribute("office:date-value", 
                                                 "2012-04-16")
print "xxx"
print body.get_user_field_decl("Dato").get_attribute("office:value-type")
print body.get_user_field_decl("Dato").get_attributes()
print body.get_user_field_value("Dato")

print "yyy"
print body.get_user_field_decl("Leif").get_attribute("office:value-type")
print body.get_user_field_decl("Leif").get_attributes()
print body.get_user_field_value("Leif")

# Save the document object as file
document.save(target=documentpath, pretty=True)
