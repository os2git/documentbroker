import ez_setup
ez_setup.use_setuptools()

from setuptools import setup, find_packages

setup(
    name = "document_broker",
    version = open('VERSION').read().strip(),
    author = "Carsten Agger",
    author_email = "carstena@magenta-aps.dk",
    description = "Magenta Document Broker",
    url = "http://www.magenta-aps.dk",
    license="GPLv3", 
    packages=['document_broker', 'document_templates'],
    long_description=open('README').read(),
    include_package_data = True
)
