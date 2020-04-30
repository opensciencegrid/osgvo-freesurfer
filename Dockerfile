FROM opensciencegrid/osgvo-el7:latest

# deps
RUN yum -y install \
      tcsh \
      https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/7.0.0/freesurfer-CentOS7-7.0.0-1.x86_64.rpm

# note symlink to license file coming with the job
RUN ls -l /usr/local/freesurfer/ && \
    ln -s /srv/license.txt /usr/local/freesurfer/7.0.0-1/license.txt

COPY setup.sh /opt/setup.sh

# build info
RUN echo "Timestamp:" `date --utc` | tee /image-build-info.txt

