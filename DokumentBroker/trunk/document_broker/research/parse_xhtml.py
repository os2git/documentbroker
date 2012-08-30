"""Simple proof-of-concept XHTML parsing with lxml"""

import re

from lxml import etree



class ExtractFieldsTarget(object):
    """Class to extract fields from an XML document."""
    
    is_style = lambda self, s: s.lower() == 'style'

    @staticmethod
    def html_tag(tag):
        XHTML_NS = '{http://www.w3.org/1999/xhtml}'
        new_tag = tag[len(XHTML_NS):] if tag.startswith(XHTML_NS) else tag
        return new_tag

    def __init__(self, fields):
        self._fields = fields
        self._in_style_tag = False
        self._current_tag = ''

    def start(self, tag, attrib):
        tag = self.html_tag(tag)
        if self.is_style(tag):
            self._in_style_tag= True
        self._current_tag  = tag

    def end(self, tag):
        tag = self.html_tag(tag)
        if self.is_style(tag):
            self._in_style_tag = False
        self._current_tag = ''

    def data(self, data):
        if not self._in_style_tag:
            user_fields = re.findall(r'#\w+', data)
            for w in user_fields:
                self._fields.append(w[1:])

    def comment(self, text):
        pass

    def close(self):
        print "Closed!"
    

path = 'xhtml_template.html'
fields = []
target = ExtractFieldsTarget(fields)

parser = etree.XMLParser(ns_clean=True, remove_blank_text=True, target=target)
tree = etree.parse(path, parser)


assert(len(parser.error_log) == 0)

print set(fields)

