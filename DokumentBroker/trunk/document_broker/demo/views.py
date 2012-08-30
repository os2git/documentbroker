
from django.shortcuts import redirect, render_to_response
from django.template import RequestContext
from django.http import HttpResponseNotFound

from forms import SelectTemplateForm, FieldsForm
from utils import generate_document, get_template_fields

def select_template(request):
    form = SelectTemplateForm(request.POST or None)
    if form.is_valid():
        # Supply template ID for show_fields
        return redirect('show_fields/{0}/'.format(request.POST['template']))

    return render_to_response('select_template.html', {'form': form}, 
            context_instance=RequestContext(request))

def show_fields(request, template=None):
    if template:
        fields = get_template_fields(template)
        form = FieldsForm(request.POST or None, fields=fields)
        if form.is_valid():
            result_url = generate_document(template,
                    { field : value  for field, value in 
                        form.get_field_data() } )
            return render_to_response('result_page.html', { 'url': result_url })

        return render_to_response('show_fields.html', {'form': form},
                context_instance=RequestContext(request))
    else:
        return HttpResponseNotFound()



