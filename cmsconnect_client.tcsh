#! /bin/tcsh

# Let's load the connect client module from OASIS.
# Workaround for undefined LMOD variables:
set LMOD_FULL_SETTARG_SUPPORT=no ; set LMOD_SETTARG_CMD=:
source /cvmfs/oasis.opensciencegrid.org/osg/modules/lmod/current/init/tcsh
module load connect-client

# The above uses its own version of python and modules, 
# which fails if the user cmsenv a release afterwards.
# Ideally, we should have the client available in CMS releases.
# Workardound: Add these without depending on the python 2.7 binary in oasis.

# Get paramiko location
set PARAMIKO_DIR=`python -c 'import os; import paramiko; print os.path.dirname(paramiko.__path__[0])'`
if ( $? != 0 ) then
   echo "Could not load paramiko module. Exiting..."
   exit 1
endif
# Get connect
set CONNECT_BIN=`which connect`
set CONNECT_DIR=`dirname ${CONNECT_BIN}`
if ( $? != 0 ) then
   echo "Could not load paramiko module. Exiting..."
   exit 1
endif

# Unload connect module
module del connect-client

# Now, export variables above
setenv PYTHONPATH ${PYTHONPATH}:${PARAMIKO_DIR}
setenv PATH ${CONNECT_DIR}:${PATH}
