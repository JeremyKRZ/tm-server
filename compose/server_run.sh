#!/bin/bash

echo "HOME: ${HOME}"
echo "SERVER_HOME: ${SERVER_HOME}"
echo "SERVER_TITLE: ${SERVER_TITLE}"
echo "SERVER_NAME: ${SERVER_NAME}"
echo "TRACKLIST: ${TRACKLIST}"

# func: keep tmserver running
run_tmserver() {
  cd $SERVER_HOME
  pwd
  while :
  do
    echo "TrackManiaServer starting..."
    ./TrackmaniaServer /nodaemon \
      /dedicated_cfg="dedicated_cfg.xml" \
      /game_settings="MatchSettings/${TRACKLIST}" \
      /title="${SERVER_TITLE}" \
      /servername="${SERVER_NAME}"
    echo "TrackManiaServer exited, restarting in 15 seconds..."
    sleep 15
  done
}

# run services
./dl_maps_from_bucket.sh
run_tmserver &
wait