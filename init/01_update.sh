#!/usr/bin/with-contenv bash
echo "updating packages"
apt-get update && apt-get upgrade
echo "grabbing latest mp4automator"
[[ ! -d /mp4automator/.git ]] && (git clone git://github.com/mdhiggins/sickbeard_mp4_automator.git /mp4automator && chown -R abc:abc /mp4automator)
echo "setting up mp4Automator"
[[ ! -f /mp4automator/autoProcess.ini ]] && (cp /mp4automator/autoProcess.ini.sample /mp4automator/autoProcess.ini)

echo "updating permissions"
chmod 775 -R /mp4automator

cp -f /mp4automator/NZBGetPostProcess.py /opt/nzbget/scripts/NZBGetPostProcess.py

echo "installing pip packages"
pip install --upgrade PIP
pip install --upgrade requests
pip install --upgrade requests[security]
pip install --upgrade requests-cache
pip install --upgrade babelfish
pip install --upgrade 'guessit<2'
pip install --upgrade 'subliminal<2'
pip install --upgrade qtfaststart
pip install --upgrade gevent
pip install --upgrade tmdbsimple
pip install --upgrade mutagen
pip uninstall --yes stevedore
pip install stevedore==1.19.1
