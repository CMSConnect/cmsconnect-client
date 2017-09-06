#! /bin/bash

# First, check if a CMSSW release is in the environment
if [ "x$CMSSW_RELEASE_BASE" == "x" ]; then
   echo "No CMSSW environment found. Please, cmsenv a release before starting."
   exit 1
fi

echo "- The Connect client will be installed in ~/software/connect-client"

# Now, install pip
wget -O - https://bootstrap.pypa.io/get-pip.py | python - --user -U > pip_install.log 2>&1
result=$?
if [ $result != 0 ]; then
   echo "There were issues installing pip. See pip_install.log"
   exit 2
fi

export PATH="$HOME/.local/bin:$PATH"
# Now, get the client from git
INSTALL_TMP="$(mktemp -d --tmpdir=$HOME)"
cd "$INSTALL_TMP"
git clone --recursive https://github.com/CMSConnect/connect-client
cd connect-client

# Install connect-client
CLIENT_PATH=$HOME/software/connect-client
bash install.sh $CLIENT_PATH
result=$?
if [ $result != 0 ]; then
   echo "Could not install the client."
   exit 3
fi
cd -

# Cleanup
rm -rf "${PIP_TMP}"
rm -rf "$INSTALL_TMP"

# Create a source script
cat << EOF > $CLIENT_PATH/client_source.sh
#! /bin/bash
export PATH="$CLIENT_PATH/bin:\$PATH"
echo "All set."
echo "Please, refer to:"
echo "https://twiki.cern.ch/twiki/bin/view/CMSPublic/WorkBookCMSConnect#Using_the_Connect_client"
echo "for the documentation."
EOF

cat << EOF > $CLIENT_PATH/client_source.tcsh
#! /bin/tcsh
setenv PATH ${CLIENT_PATH}/bin:\${PATH}"
echo "All set."
echo "Please, refer to:"
echo "https://twiki.cern.ch/twiki/bin/view/CMSPublic/WorkBookCMSConnect#Using_the_Connect_client"
echo "for the documentation."
EOF

echo -e "- All done. To use the client, just:\n\n source \~/software/connect-client/client_source.sh\n (or tcsh, depending on your SHELL)."
