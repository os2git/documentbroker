#!/usr/bin/env bash

# Download lpod software from official repository and install it.
# This should be run in the virtualenv where the document broker
# is to be installed.

# Assume web address etc. does not change.

LOGFILE=/tmp/lpod_install.log
INSTALL_DIR=/tmp/lpod_install
LPOD_SOURCE=http://download.lpod-project.org/lpod-python/lpod-python-0.9.3.tar.gz

mkdir -p $INSTALL_DIR

pushd $INSTALL_DIR > $LOGFILE


echo "Installing lpod ..." 

git clone git://gitorious.org/lpod-project/lpod-python.git >> $LOGFILE



cd lpod-python >> $LOGFILE

python setup.py install >> $LOGFILE

RETVAL=$?
echo "Result: $RETVAL"

# Clean up if success, leave for debugging purposes if failure.

[ $RETVAL -eq 0 ] && echo 'Success!'; rm -rf $INSTALL_DIR
[ $RETVAL -ne 0 ] && echo 'Failure!'

popd >> $LOGFILE

exit $RETVAL 




