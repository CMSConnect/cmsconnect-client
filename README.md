# connect-client
Scripts to setup the connect client from OASIS

## Instructions
### To use the client from CVMFS 

```
source cmsconnect_client.<sh/tcsh>
```
Note: This version could be incompatible with CMSSW releases, so if you need to `cmsenv` a realease, you can install the client instead.

### To install the client

- Setup a CMSSW release first. E.g:
```
cmsrel CMSSW_7_1_28; cd CMSSW_7_1_28; cmsenv
```

- Run the installer

```
bash cmsconnect_client_install.sh
```

the client will be installed inside ~/software/connect-client

#### Using the installed client

To use the client, simply source the script

```
source ~/software/connect-client/client_source.sh (or .tcsh)
```
