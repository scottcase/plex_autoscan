FROM ubuntu:bionic
LABEL maintainer="Scott <scott.case.1@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y python python-pip tzdata
    
################################
### Config:
###

# Add pip requirements
COPY /requirements.txt /tmp/requirements.txt


### Install pyinotify service.
RUN \
    echo "**** Install pip packages ****" \
        && python -m pip install --no-cache-dir -r /tmp/requirements.txt  \
    && \
    echo "**** Cleanup ****" \
    && rm -rf \
       /tmp/* \
       /var/tmp/*
# add local files
COPY /  /app/

EXPOSE 3468
WORKDIR /app
VOLUME /config
#CMD ["bash"]
#ENTRYPOINT ["/script.sh"]
#CMD [ "python", "scan.py server --loglevel=INFO" ]
CMD python scan.py $ENV1