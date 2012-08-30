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
            ] = forms.CharField(label=field, required=False)

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
