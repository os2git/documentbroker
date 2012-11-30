# Copyright (C) 2012  Magenta ApS.
#
# Authors: Carsten Agger (carstena@magenta-aps.dk),
#          Dennis Isaksen (dennis@magenta-aps.dk),
#          Leif Lodahl (leif@magenta-aps.dk)
#
# This code may be freely reused and modified, provided this copyright notice
# is retained. See the COPYING file for details.

# IMPORTANT: When installing using the "install.sh" script, this file is
# overwritten.  This means that structural changes should also be included in
# the here document in install.sh.
"""
This module contains various settings needed by the client libraries.

TODO: For the time being this is just a simple Python file where we save the
parameters on single lines as

VARIABLE = <Value>

At some later point, perhaps switch to ConfigParser format in order to have a
unified configuration format for all platforms - dependent on how much
configuration we're going to actually need.
"""

BROKER_BASE_URL = ('http://ec2-23-20-209-182.compute-1.amazonaws.com/'
                   + 'document_broker')
BROKER_URL = BROKER_BASE_URL + '/broker-xml/'

TEMPLATE_BASE_URL = ('http://ec2-23-20-209-182.compute-1.amazonaws.com:8000/' +
                     'document_templates')
TEMPLATE_URL = TEMPLATE_BASE_URL + '/template-xml/'
CLIENT_ID = '553b6807-851d-4b76-a4c1-3f683fc20de3'
CLIENT_PASSWORD = "fa8019f4ea50a1eab471a816d111853dadbf52d7"

# SSL client certificate settings. If SSL_DO_USE is set, the following two
# parameters MUST be set, and must point to a valid certificate.
SSL_DO_USE = False
(SSL_CERT_FILE, SSL_KEY_FILE) = (
    '/home/carstena/src/document_broker/client/' +
    '.ssl_keyfiles/553b6807-851d-4b76-a4c1-3f683fc20de3.crt',
    '/home/carstena/src/document_broker/client/' +
    '.ssl_keyfiles/553b6807-851d-4b76-a4c1-3f683fc20de3.key')
