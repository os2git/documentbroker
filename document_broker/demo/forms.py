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

from django import forms

from utils import get_templates


class SelectTemplateForm(forms.Form):
    template = forms.ChoiceField(choices=get_templates())


class FieldsForm(forms.Form):
    """This form will render the template fields dynamically."""
    def __init__(self, *args, **kwargs):
        dynamic_fields = kwargs.pop('fields')
        super(FieldsForm, self).__init__(*args, **kwargs)

        dynamic_fields.sort()
        for i, field in enumerate(dynamic_fields):
            self.fields[
                'document_field_{0}'.format(i)
            ] = forms.CharField(label=field['name'], required=False)

    def get_field_data(self):
        for name, value in self.cleaned_data.items():
            if name.startswith('document_field_'):
                yield(self.fields[name].label, value)


class ResultForm(forms.Form):
    command = forms.ChoiceField(
        choices=[('SHA1', 'Check SHA1-sum'), ('ACK', 'Kvitter og slet')],
        required=False,
        label='Kommando'
    )
