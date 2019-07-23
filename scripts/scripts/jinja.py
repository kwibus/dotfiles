#! /usr/bin/python

from jinja2 import Template
import sys
data = sys.stdin.read()
template = Template(data)
print (template.render())
