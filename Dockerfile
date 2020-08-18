FROM opensciencegrid/osgvo-el7:latest

LABEL opensciencegrid.name="FreeSurfer"
LABEL opensciencegrid.description="A software package for the analysis and visualization of structural and functional neuroimaging data from cross-sectional or longitudinal studies"
LABEL opensciencegrid.url="https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferWiki"
LABEL opensciencegrid.category="Tools"
LABEL opensciencegrid.definition_url="https://github.com/opensciencegrid/osgvo-freesurfer"

# deps
RUN yum -y install \
      tcsh

# FreeSurfer 6.0.1 - note symlink to license file coming with the job
RUN cd /opt && \
    wget -qO- https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/6.0.1/freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.1.tar.gz | tar zxv --no-same-owner -C /opt \
    --exclude='freesurfer/trctrain' \
    --exclude='freesurfer/subjects/fsaverage_sym' \
    --exclude='freesurfer/subjects/fsaverage3' \
    --exclude='freesurfer/subjects/fsaverage4' \
    --exclude='freesurfer/subjects/fsaverage5' \
    --exclude='freesurfer/subjects/fsaverage6' \
    --exclude='freesurfer/subjects/cvs_avg35' \
    --exclude='freesurfer/subjects/cvs_avg35_inMNI152' \
    --exclude='freesurfer/subjects/V1_average' \
    --exclude='freesurfer/average/mult-comp-cor' \
    --exclude='freesurfer/lib/cuda' \
    --exclude='freesurfer/lib/qt' \
    && \
    mv freesurfer freesurfer-6.0.1 && \
    ln -s /srv/license.txt /opt/freesurfer-6.0.1/license.txt

COPY setup.sh /opt/setup.sh

COPY labels.json /.singularity.d/

# build info
RUN echo "Timestamp:" `date --utc` | tee /image-build-info.txt

