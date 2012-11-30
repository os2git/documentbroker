# -*- coding: utf-8 -*-
# Copyright (C) 2012  Magenta ApS.
#
# Authors: Carsten Agger (carstena@magenta-aps.dk),
#          Dennis Isaksen (dennis@magenta-aps.dk),
#          Leif Lodahl (leif@magenta-aps.dk)
#
# This code may be freely reused and modified, provided this copyright notice
# is retained. See the COPYING file for details.
"""This is a client library for the document broker. It may be used directly by
programmers of user systems, or it may be used as a model implementation (in
Python). It will also be used by the template system to retrieve data from the
document broker, if necessary.

TODO: The main section is currently a simple test program. It should be changed
to become a full command line client.

It will send user authentication data, template ID and field data to the
document broker and will receive the URL of the generated document as result.

It will then download the generated document to be inspected by the user. To
begin with, everything will be hard coded."""

import xmlrpclib
import sys
import pprint
import urllib
import datetime

import document_broker_settings as settings

from client_lib import XMLRPCProxy
from template_client import TemplateServer


class DocumentBroker(XMLRPCProxy):
    """This implements the XML-RPC interface of the document broker to be used
    by client libraries. It contains the full API with all the methods needed
    by user systems - except those which are found on the template server."""

    def get_plugin_mappings(self):
        return self._rpc_srv.get_plugin_mappings()

    def get_client_systems(self, user_authentication):
        return self._rpc_srv.get_client_systems(user_authentication)

    def get_authorization(self, clid, pw):
        return self._rpc_srv.get_authorization(clid, pw)

    def generate_document(self, user_authentication, template_id, fields):
        return self._rpc_srv.generate_document(user_authentication,
                template_id, fields)

    def acknowledge_document(self, user_authentication, document):
        return self._rpc_srv.acknowledge_document(user_authentication,
                document)


(ODF, PDF) = (0, 1)


def test(verbose=True, type=ODF):

    def say(s):
        if verbose:
            print s

    broker_url = settings.BROKER_URL
    template_url = settings.TEMPLATE_URL
    client_id = settings.CLIENT_ID
    pwd = settings.CLIENT_PASSWORD

    broker = DocumentBroker(broker_url)
    ts = TemplateServer(template_url)

    fields = {}
    if type == PDF:
        fields['date'] = '2012-05-01'
        fields['count'] = '137'
        fields['afsender_adresse'] = 'Blåbærgrød'
    else:
        fields['Dato'] = '2012-05-01'
        fields['Leif'] = '137'
        fields['Svaret'] = '42'

    if type == PDF:
        template_name = "xhtml letter test with h1-h6 and p"
    else:
        template_name = "OTT Test Template"

    try:
        user_authentication = broker.get_authorization(client_id, pwd)
        say("USER AUTHENTICATION: " + user_authentication)
        client_systems = broker.get_client_systems(user_authentication)
        say("CLIENT SYSTEMS: " + str(client_systems))

        templates = ts.get_templates(client_id)
        say("TEMPLATES: " + str([t[0] for t in templates]))
        template_id = {t[0]: t[1] for t in templates}[template_name]
        say(template_id)
        (result_url, sha1sum) = broker.generate_document(
            user_authentication,
            template_id,
            fields)
        say(result_url)
        say(sha1sum)
        # TODO: Retrieve file and compare checksum when available!
        urllib.urlretrieve(result_url, result_url.split('/')[-1])
        return broker.acknowledge_document(user_authentication, result_url)
    except Exception as e:
        print "An error has occurred: " + str(e)
        raise
        return 1


def stress_test(n=1000):
    for x in range(n):
        start_time = datetime.datetime.now()
        result = test(verbose=False, type=ODF)
        end_time = datetime.datetime.now()

        print "{0}/{1}: {2} - {3}".format(x + 1, n, start_time, end_time)


if __name__ == '__main__':

    if len(sys.argv) == 1:
        # test/playground/proof of concept code
        test()
    elif len(sys.argv) == 2:
        n = int(sys.argv[1])
        stress_test(n)
    else:
        # Interactive test for the time being very head under arm - later
        # use optparse etc.
        import urllib

        try:
            broker_url = settings.BROKER_URL
            template_url = settings.TEMPLATE_URL
            ts = TemplateServer(template_url)
            broker = DocumentBroker(broker_url)
            user_authentication = broker.get_authorization(
                    settings.CLIENT_ID,
                    settings.CLIENT_PASSWORD)

            if sys.argv[1] == '-n' and len(sys.argv) > 2:
                template_name = sys.argv[2]
                # TODO: Get uuid from name
                raise RuntimeException("Not implemented.")
            else:
                template_id = sys.argv[1]

            fields = ts.get_template_fields(template_id)
            fields.sort()
            document_fields = {}
            if len(fields) > 0:
                print "Indtast feltværdier"
            for field in fields:
                value = raw_input(field + ': ')
                document_fields[field] = value
            print ""
            print document_fields
            print ""
            result_url = broker.generate_document(
                    user_authentication,
                    template_id,
                    document_fields)
            file_name = raw_input("Indtast filnavn: ")
            urllib.urlretrieve(result_url, file_name)
            broker.acknowledge_document(user_authentication, result_url)
        except Exception as e:
            print "ERROR: " + str(e)
            raise
