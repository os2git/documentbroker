"""Library of utility functions for the document_templates component."""

import os
import sys
import uuid
import hashlib

def get_install_dir():
    return os.path.abspath(
        os.path.join(os.path.dirname(os.path.abspath(__file__)), '..')
    )

def get_unique_token():
    return hashlib.sha1(unicode(uuid.uuid4())).hexdigest()


