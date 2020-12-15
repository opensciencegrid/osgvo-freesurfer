FROM opensciencegrid/osgvo-el7:latest

LABEL opensciencegrid.name="FreeSurfer"
LABEL opensciencegrid.description="A software package for the analysis and visualization of structural and functional neuroimaging data from cross-sectional or longitudinal studies"
LABEL opensciencegrid.url="https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferWiki"
LABEL opensciencegrid.category="Tools"
LABEL opensciencegrid.definition_url="https://github.com/opensciencegrid/osgvo-freesurfer"

# deps
RUN yum -y install \
      tcsh \
      https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/7.1.1/freesurfer-CentOS7-7.1.1-1.x86_64.rpm && \
    yum clean -y all && \
    rm -rf /var/tmp/yum*

# note symlink to license file coming with the job
RUN ls -l /usr/local/freesurfer/ && \
    ln -s /srv/license.txt /usr/local/freesurfer/7.1.1-1/license.txt

COPY setup.sh /opt/setup.sh

COPY labels.json /.singularity.d/

# build info
RUN echo "Timestamp:" `date --utc` | tee /image-build-info.txt

