
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
                    ] = forms.CharField(label=field)

            
    def get_field_data(self):
        for name, value in self.cleaned_data.items():
            if name.startswith('document_field_'):
                yield(self.fields[name].label, value)







