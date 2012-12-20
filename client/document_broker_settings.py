
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

BROKER_BASE_URL = 'http://document-broker.agger.magenta-aps.dk/document_broker'
BROKER_URL = (BROKER_BASE_URL + '/broker-xml/')

TEMPLATE_BASE_URL = 'http://document-broker.agger.magenta-aps.dk/document_templates'
TEMPLATE_URL = (TEMPLATE_BASE_URL + '/template-xml/')
CLIENT_ID = 'c9bf43ad-91ee-4706-a4de-4df3d53b45ef'
CLIENT_PASSWORD = "e13e9b0214aea8138b81ade09989db159af80237"

# SSL client certificate settings. If SSL_DO_USE is set, the following two
# parameters MUST be set, and must point to a valid certificate.
# In this version, the certificate  and key files are just meant as examples.
SSL_DO_USE = False
(SSL_CERT_FILE, SSL_KEY_FILE) = (
    '/home/carstena/src/svn/document_broker/client/' +
        '.ssl_keyfiles/553b6807-851d-4b76-a4c1-3f683fc20de3.crt',
            '/home/carstena/src/svn/document_broker/client/' +
            '.ssl_keyfiles/553b6807-851d-4b76-a4c1-3f683fc20de3.key')

