#!/bin/sh
# Revoke a certificate and update the CRL.
base=/etc/ssl/private
# Revoke a particular user's certificate.
openssl -revoke $base/$1/$1.pem
# Update the CRL with the new info from the database (ie. index.txt)
openssl ca -gencrl -out $base/ca.crl -crldays 7


