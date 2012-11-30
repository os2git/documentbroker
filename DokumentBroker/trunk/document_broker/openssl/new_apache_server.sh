if [  ! $1 ] 
then
    key_name="apache"
else
    key_name="$1"
fi

# Create us a key. Don't bother putting a password on it since you will need it
# to start apache. If you have a better work around I'd love to hear it.
openssl genrsa -out /etc/ssl/private/${key_name}.key 2048
# Take our key and create a Certificate Signing Request for it.
openssl req -new -key /etc/ssl/private/${key_name}.key -out /etc/ssl/private/${key_name}.csr
# Sign this bastard key with our bastard CA key.
openssl ca -in /etc/ssl/private/${key_name}.csr -cert /etc/ssl/private/ca.crt -keyfile /etc/ssl/private/ca.key -out /etc/ssl/private/${key_name}.crt
