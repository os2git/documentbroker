
import ho.pisa as pisa
import cStringIO as StringIO

path = "generated_xhtml_file.html"

output_path = "generated_pdf_file.pdf"

xhtml = open(path, 'r').read()

outfile = open(output_path, 'wb')
result = StringIO.StringIO()

pdf = pisa.pisaDocument(StringIO.StringIO(
    xhtml.encode("UTF-8")), outfile)



