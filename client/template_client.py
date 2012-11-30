# Copyright (C) 2012  Magenta ApS.
#
# Authors: Carsten Agger (carstena@magenta-aps.dk),
#          Dennis Isaksen (dennis@magenta-aps.dk),
#          Leif Lodahl (leif@magenta-aps.dk)
#
# This code may be freely reused and modified, provided this copyright notice
# is retained. See the COPYING file for details.
"""This is a client library for the document template server. It may be used
directly by clients needing to retrieve data from the template server, but
otherwise it may serve as a model implementation for programmers of user
systems.

It is also used by the document broker to retrieve data from the template
system.

The main section is a simple test program. TODO: As is the case for the
document broker client, the main section should be expanded to include a
command line client for convenient debugging."""

import document_broker_settings as settings

from client_lib import XMLRPCProxy


class TemplateServer(XMLRPCProxy):

    def get_template(self, client_system_id, template_id):
        return self._rpc_srv.get_template(client_system_id, template_id)

    def get_templates(self, client_system_id):
        return self._rpc_srv.get_templates(client_system_id)

    def get_template_fields(self, template_id):
        return self._rpc_srv.get_template_fields(template_id)

    def get_thumbnail_image(self, template_id):
        return self._rpc_srv.get_thumbnail_image(template_id)


if __name__ == '__main__':
    """ Unit test-style playground."""

    template_url = settings.TEMPLATE_URL
    template_server = TemplateServer(template_url)

    system_name = "Magenta test"

    try:
        client_id = '553b6807-851d-4b76-a4c1-3f683fc20de3'
        templates = template_server.get_templates(client_id)
        f = lambda x, y, z: "Navn: {0}, ID: {1}, URL: {2}".format(x, y, z)
        # Template tuple = name, id, url, do_pdf
        for (n, i, u, d) in templates:
            print f(n, i, u)
        _, uuid, _, _ = templates[0]
        print uuid
        fields = template_server.get_template_fields(uuid)
        print fields
    except Exception as e:
        print "An error has occurred: " + str(e)
        raise
