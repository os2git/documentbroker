# Copyright (C) 2012  Magenta ApS.
#
# Authors: Carsten Agger (carstena@magenta-aps.dk),
#          Dennis Isaksen (dennis@magenta-aps.dk),
#          Leif Lodahl (leif@magenta-aps.dk)
#
# This code may be freely reused and modified, provided this copyright notice
# is retained. See the COPYING file for details.
"""
This module contains various settings needed by the client libraries.

TODO: For the time being this is just a simple Python file where we save the
parameters on single lines as

VARIABLE = <Value>

At some later point, perhaps switch to ConfigParser format in order to have a
unified configuration format for all platforms - dependent on how much
configuration we're going to actually need.
"""

BROKER_BASE_URL = 'http://ec2-23-20-209-182.compute-1.amazonaws.com'
BROKER_URL = (BROKER_BASE_URL +
        '/document_broker/broker-xml/')

TEMPLATE_BASE_URL = 'http://ec2-23-20-209-182.compute-1.amazonaws.com:8000'
TEMPLATE_URL = (TEMPLATE_BASE_URL +
        '/document_templates/template-xml/')
CLIENT_ID = '553b6807-851d-4b76-a4c1-3f683fc20de3'
CLIENT_PASSWORD = "fa8019f4ea50a1eab471a816d111853dadbf52d7"
