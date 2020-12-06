FROM ghcr.io/linuxserver/nzbget
LABEL maintainer="halfdeadgames"

# Update package repositories
RUN apk update update

# Install MP4 Automator

ENV PACKAGES="\
  git \
  gcc \
  musl-dev \
  libffi-dev \
  python2-dev \
  python3-dev \
  py-setuptools \
  ffmpeg"

RUN apk del python3
RUN apk add --update py-pip
RUN apk add --no-cache $PACKAGES
RUN pip install requests requests[security] requests-cache babelfish 'guessit<2' 'subliminal<2' 
RUN pip uninstall -y stevedore
RUN pip install stevedore==1.19.1
RUN pip install qtfaststart gevent tmdbsimple mutagen

RUN git clone git://github.com/mdhiggins/sickbeard_mp4_automator.git mp4automator

#Set script file permissions
RUN chmod 775 -R /mp4automator

#Move script to correct location
RUN mkdir /opt/nzbget
RUN mkdir /opt/nzbget/scripts
RUN cp /mp4automator/NZBGetPostProcess.py /opt/nzbget/scripts/NZBGetPostProcess.py

#Adding Custom files
ADD init/ /etc/cont-init.d/
RUN chmod -v +x /etc/cont-init.d/*.sh

VOLUME /mp4automator
