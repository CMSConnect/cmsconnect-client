#! /bin/tcsh

echo "[Note]: This client comes from CVMFS, but it won't work if you have a CMSSW release in the environment."
echo "(i.e: if you have typed: cmsenv in a release before using the client)"
echo "To use the client after sourcing a CMSSW release, use:"
echo "bash cmsconnect_client_install.sh"

echo "Sourcing..."
# Let's load the connect client module from OASIS.
# Workaround for undefined LMOD variables:
set LMOD_FULL_SETTARG_SUPPORT=no ; set LMOD_SETTARG_CMD=:
source /cvmfs/oasis.opensciencegrid.org/osg/modules/lmod/current/init/tcsh
module load connect-client

echo "All set. You can type:"
echo
echo "connect setup <username>@login.uscms.org"
echo
echo "to setup your account"
echo "Please, refer to:"
echo "https://twiki.cern.ch/twiki/bin/view/CMSPublic/WorkBookCMSConnect#Using_the_Connect_client"
echo "for the documentation."
