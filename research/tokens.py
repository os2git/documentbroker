
"""This is a very simple script to illustrate the improbability of collisions
with our UUID + SHA1 based unique tokens."""
import hashlib
import uuid

def get_unique_token():
    return hashlib.sha1(unicode(uuid.uuid4())).hexdigest()

s = set()
t = get_unique_token()

while t not in s:
    try:
        s.add(t)
        t = get_unique_token()
    except KeyboardInterrupt:
        print "Tokens tried so far: ", len(s)
        t = get_unique_token()
        continue


