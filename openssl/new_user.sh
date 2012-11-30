#!/bin/sh
# The base of where our SSL stuff lives.
base="/etc/ssl/private"
# Were we would like to store keys... in this case we take the username given
# to us and store everything there.
mkdir -p $base/users/$1/

# Let's create us a key for this user... No password since it's going to be
# used from a command line pgrogram.
openssl genrsa -out $base/users/$1/$1.key 2048
# Create a Certificate Signing Request for said key.
openssl req -new -key $base/users/$1/$1.key -out $base/users/$1/$1.csr
# Sign the key with our CA's key and cert and create the user's certificate out
# of it.
openssl ca -in $base/users/$1/$1.csr -cert $base/ca.crt -keyfile $base/ca.key -out $base/users/$1/$1.crt

# This is the tricky bit... convert the certificate into a form that most
# browsers will understand PKCS12 to be specific.
# The export password is the password used for the browser to extract the bits
# it needs and insert the key into the user's keychain.
# Take the same precaution with the export password that would take with any
# other password based authentication scheme.
openssl pkcs12 -export -clcerts -in $base/users/$1/$1.crt -inkey $base/users/$1/$1.key -out $base/users/$1/$1.p12
