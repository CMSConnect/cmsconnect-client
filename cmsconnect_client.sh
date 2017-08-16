#! /bin/bash

# Let's load the connect client module from OASIS.
source /cvmfs/oasis.opensciencegrid.org/osg/modules/lmod/current/init/bash
module load connect-client

# The above uses its own version of python and modules, 
# which will fail if the user cmsenv a release.
# Ideally, we should have the client available in CMS releases.
# Workardound: Get paramiko and the client from cvmfs 
# without depending on the python 2.7 binary in OASIS.

# Get paramiko location
PARAMIKO_DIR=$(python -c 'import os; import paramiko; print os.path.dirname(paramiko.__path__[0])')
if [ $? != 0 ]; then
   echo "Could not load paramiko module. Exiting..."
   exit 1
fi
# Get connect
CONNECT_DIR=$(dirname $(which connect))
if [ $? != 0 ]; then
   echo "Could not load paramiko module. Exiting..."
   exit 1
fi

# Unload connect module
module del connect-client

# Now, export variables above
export PYTHONPATH=${PYTHONPATH}:${PARAMIKO_DIR}
export PATH=${CONNECT_DIR}:${PATH}
