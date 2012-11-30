# Copyright (C) 2012  Magenta ApS.
#
# Authors: Carsten Agger (carstena@magenta-aps.dk),
#          Dennis Isaksen (dennis@magenta-aps.dk),
#          Leif Lodahl (leif@magenta-aps.dk)
#
# This file is part of the Magenta Document Broker.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranties of
# MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR
# PURPOSE.  See the Mozilla Public License for more details.

from django.shortcuts import redirect, render_to_response
from django.template import RequestContext
from django.http import HttpResponseNotFound

from forms import SelectTemplateForm, FieldsForm, ResultForm
from utils import generate_document, generate_preview, get_template_fields
from utils import get_templates, get_all_template_data
from utils import validate_sha1, acknowledge_document
from utils import get_thumbnail_image
from client.document_broker_settings import TEMPLATE_URL, BROKER_BASE_URL


def select_template(request):
    """Start the demo process by selecting a template to generate."""
    form = SelectTemplateForm(request.POST or None)
    # Reload template list so new templates are included.
    # form.fields['template'].choices = get_templates()

    """
    if form.is_valid():
        # Supply template ID for show_fields
        return redirect('show_fields/{0}/'.format(request.POST['template']))
    """
    """
    We test the new design:
    """
    templates = get_all_template_data()

    """
    For the time being we only return a portion of the templates - only the
    first 10. That is to ease up our demo design.
    """

    first_10_templates = []
    i = 0
    if len(templates) > 10:
        while i < 10:
            if get_thumbnail_image(templates[i][1]) != "":
                templates[i].append(TEMPLATE_URL + get_thumbnail_image(
                    templates[i][1])
                )
            else:
                templates[i].append("")
            first_10_templates.append(templates[i])
            i = i + 1
    else:
        for t in templates:
            if get_thumbnail_image(t[1]) != "":
                t.append(TEMPLATE_URL + get_thumbnail_image(t[1]))
            else:
                t.append("")
            first_10_templates.append(t)

    """
    return render_to_response(
        'select_template.html',
        {'form': form},
        context_instance=RequestContext(request)
    )
    """
    return render_to_response(
        'new_select_template.html',
        {
            'templates': first_10_templates,
            'broker_url': BROKER_BASE_URL
        },
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
            if (
                'result_url' not in request.POST
                and
                request.POST['preview_format'] == ""
            ):
                # Document not generated yet
                (result_url, sha1sum) = generate_document(
                    template,
                    {field: value for field, value in
                        form.get_field_data()})
            elif (
                'result_url' not in request.POST
                and
                request.POST['preview_format'] != ""
            ):
                #User has requested a preview, so we generate one acording
                #to his/her requested format.
                return_format = request.POST['preview_format']
                (result_url, sha1sum) = generate_preview(
                    template,
                    {field: value for field, value in
                    form.get_field_data()},
                    return_format, 0
                )
            else:
                # Document already generated, retrieve URL
                # and SHA1 sum from form inputs.
                result_url = request.POST['result_url']
                sha1sum = request.POST['sha1sum']

            return show_result(request, result_url, sha1sum)
        else:
            # GET request, not submitted yet.
            """
            return render_to_response(
                'show_fields.html',
                {'form': form},
                context_instance=RequestContext(request))
            """

            """
            We fetch an example image if such exists.
            """
            image = get_thumbnail_image(template)
            if image != "":
                image = TEMPLATE_URL + image
            else:
                image = "media/files/styling/trans.gif"
            return render_to_response(
                'new_show_fields.html',
                {
                    'form': form,
                    'feilds': fields,
                    'image': image,
                    'broker_url': BROKER_BASE_URL
                },
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
        """
        We fetch an example image if such exists.
        """
        print "POST: " + str(request.POST)
        """
        image = get_thumbnail_image(request.POST['template'])
        if image != "":
            image = TEMPLATE_URL + image
        else:
            image = "media/files/styling/trans.gif"
        """

    return render_to_response(
        'new_result_page.html',
        {'url': url, 'sha1sum': sha1sum, 'status': status, 'form': form,
        'redirect': redirect, 'broker_url': BROKER_BASE_URL},
        context_instance=RequestContext(request))
