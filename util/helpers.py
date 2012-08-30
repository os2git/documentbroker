"""Library of utility functions for the document_templates component."""

import os
import sys

def get_install_dir():
    return os.path.abspath(
        os.path.join(os.path.dirname(os.path.abspath(__file__)), '..')
    )

