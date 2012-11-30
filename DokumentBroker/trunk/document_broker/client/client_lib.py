# Copyright (C) 2012  Magenta ApS.
#
# Authors: Carsten Agger (carstena@magenta-aps.dk),
#          Dennis Isaksen (dennis@magenta-aps.dk),
#          Leif Lodahl (leif@magenta-aps.dk)
#
# This code may be freely reused and modified, provided this copyright notice
# is retained. See the COPYING file for details.
"""This module contains some common functionality for the XML-RPC clients for
broker and template server."""

import xmlrpclib
import document_broker_settings as settings


# Helper class for SSL communication
class SafeTransportWithCert(xmlrpclib.SafeTransport):
    __cert_file = settings.SSL_CERT_FILE
    __key_file = settings.SSL_KEY_FILE

    def make_connection(self, host):
        host_with_cert = (host, {
            'key_file': self.__key_file,
            'cert_file': self.__cert_file
        })
        return xmlrpclib.SafeTransport.make_connection(self, host_with_cert)


class XMLRPCProxy:

    def __init__(self, url, verbose=False):
        # For now, don't try/catch - just pass on
        # any exception that might occur in the transport
        # layer. We can improve that later, if need be.
        # TODO: Introduce user authentication.
        self._url = url
        if settings.SSL_DO_USE:
            self._transport = SafeTransportWithCert()
            self._rpc_srv = xmlrpclib.ServerProxy(self._url, verbose=verbose,
                                                  transport=self._transport)
        else:
            self._rpc_srv = xmlrpclib.ServerProxy(self._url, verbose=verbose)
