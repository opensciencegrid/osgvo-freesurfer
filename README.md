# osgvo-freesurfer

OSG VO's container for the FreeSurfer application. Currently the image contains:

 - FreeSurver 7.1.1
 - FreeSurver 7.0.0
 - FreeSurver 6.0.1
 - FreeSurver 6.0.0

## FreeSurfer Workflow

Please see [FreeSurfer OSG Workflow](https://github.com/pegasus-isi/freesurfer-osg-workflow) for a tool allowing you to process whole directories of subjects, using this image.

## Single job FreeSurfer example

In order to use FreeSurfer, you need your own license file. See the [FreeSurfer documentation](https://surfer.nmr.mgh.harvard.edu/fswiki/DownloadAndInstall#License) for details on how to obtain the license. Once you have it, name it `license.txt` and put it in the same directory as you are submitting the job from, as the file gets sent with the job.

The following example job has three files: `job.submit`, `freesurfer-wrapper.sh` and `license.txt`

`job.submit` contents:
```

Requirements = HAS_SINGULARITY == True && TARGET.GLIDEIN_ResourceName =!= MY.MachineAttrGLIDEIN_ResourceName1 && TARGET.GLIDEIN_ResourceName =!= MY.MachineAttrGLIDEIN_ResourceName2 && TARGET.GLIDEIN_ResourceName =!= MY.MachineAttrGLIDEIN_ResourceName3 && TARGET.GLIDEIN_ResourceName =!= MY.MachineAttrGLIDEIN_ResourceName4
+SingularityImage = "/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-freesurfer:latest/"

executable = freesurfer-wrapper.sh
transfer_input_files = license.txt, sub-THP0001_ses-THP0001UCI1_run-01_T1w.nii.gz

error = job.$(Cluster).$(Process).error
output = job.$(Cluster).$(Process).output
log = job.$(Cluster).$(Process).log

request_cpus = 1
request_memory = 1 GB
request_disk = 4 GB

queue 1
```

`freesurfer-wrapper.sh` contents:
```
#!/bin/bash

set -e

# osgvo-neuroimaging environment
. /opt/setup.sh

# license file comes with the job
export FS_LICENSE=`pwd`/license.txt

export SUBJECTS_DIR=$PWD

recon-all -subject THP0001 -i sub-THP0001_ses-THP0001UCI1_run-01_T1w.nii.gz -autorecon1 -cw256

# tar up the subjects directory so it gets transferred back
tar czf THP0001.tar.gz THP0001
rm -rf THP0001

```

