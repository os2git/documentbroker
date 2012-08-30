# Copyright (C) 2012  Magenta ApS.
#
# Authors: Carsten Agger (carstena@magenta-aps.dk),
#          Dennis Isaksen (dennis@magenta-aps.dk),
#          Leif Lodahl (leif@magenta-aps.dk)
#
# This file is part of the Magenta Document Broker.
#
# The Magenta Document Broker is free software: you can redistribute it
# and/or modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranties of
# MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR
# PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program.  If not, see <http://www.gnu.org/licenses/>.

from django.shortcuts import redirect, render_to_response
from django.template import RequestContext
from django.http import HttpResponseNotFound

from forms import SelectTemplateForm, FieldsForm, ResultForm
from utils import generate_document, get_template_fields, get_templates
from utils import validate_sha1, acknowledge_document


def select_template(request):
    """Start the demo process by selecting a template to generate."""
    form = SelectTemplateForm(request.POST or None)
    # Reload template list so new templates are included.
    form.fields['template'].choices = get_templates()

    if form.is_valid():
        # Supply template ID for show_fields
        return redirect('show_fields/{0}/'.format(request.POST['template']))

    return render_to_response(
        'select_template.html',
        {'form': form},
        context_instance=RequestContext(request)
    )


def show_fields(request, template=None):
    """ Show document fields and generate document if
    necessary"""
    # TODO: Refactor this spaghetti!
    if template:
        fields = get_template_fields(template)
        form = FieldsForm(request.POST or None, fields=fields)
        if form.is_valid():
            if 'result_url' not in request.POST:
                # Document not generated yet
                (result_url, sha1sum) = generate_document(
                    template,
                    {field: value for field, value in
                        form.get_field_data()})
            else:
                # Document already generated, retrieve URL
                # and SHA1 sum from form inputs.
                result_url = request.POST['result_url']
                sha1sum = request.POST['sha1sum']

            return show_result(request, result_url, sha1sum)
        else:
            # GET request, not submitted yet.
            return render_to_response(
                'show_fields.html',
                {'form': form},
                context_instance=RequestContext(request))
    else:
        return HttpResponseNotFound()


def show_result(request, url, sha1sum):
    """Show the result page - execute commands for the downloaded file."""
    form = ResultForm(request.POST or None)
    status = ""
    redirect = False
    if form.is_valid() and 'command' in request.POST:
        # Result form was submitted
        command = request.POST['command']
        if command == 'SHA1':
            # Validate SHA1 sum, output result
            if validate_sha1(url, sha1sum):
                status = "SHA1-summen er gyldig!"
            else:
                status = "SHA1-summen er IKKE gyldig, filen er korrumperet."
        if command == 'ACK':
            # Acknowledge receipt of document
            acknowledge_document(url)
            status = "Dokumentet er afsluttet, stiller tilbage ..."
            redirect = True
    else:
        # No ack or sha1 command submitted, just render
        # result page.
        pass

    return render_to_response(
        'result_page.html',
        {'url': url, 'sha1sum': sha1sum, 'status': status, 'form': form,
        'redirect': redirect},
        context_instance=RequestContext(request))
