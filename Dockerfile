FROM ghcr.io/linuxserver/nzbget
LABEL maintainer="halfdeadgames"

# Update package repositories
RUN apk update update

# Install MP4 Automator
RUN apk add --no-cache python2
RUN apk add py2-setuptools \
  py2-pip \
  git \
  ffmpeg
RUN pip2 install --upgrade PIP
RUN pip2 install requests
RUN pip2 install requests[security]
RUN pip2 install requests-cache
RUN pip2 install babelfish
RUN pip2 install 'guessit<2'
RUN pip2 install 'subliminal<2'
RUN pip2 uninstall -y stevedore
RUN pip2 install stevedore==1.19.1
RUN pip2 install qtfaststart
RUN pip2 install gevent
RUN pip2 install tmdbsimple
RUN pip2 install mutagen
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
