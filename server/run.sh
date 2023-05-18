#!/bin/bash

echo "HOME: ${HOME}"
echo "SERVER_HOME: ${SERVER_HOME}"
echo "SERVER_TITLE: ${SERVER_TITLE}"
echo "SERVER_NAME: ${SERVER_NAME}"
echo "TRACKLIST: ${TRACKLIST}"

# func: keep tmserver running
run_tmserver() {
  cd $SERVER_HOME
  while :
  do
    echo "TrackManiaServer starting..."
    ./TrackmaniaServer /nodaemon /nologs \
      /dedicated_cfg="dedicated_cfg.txt" \
      /game_settings="MatchSettings/${TRACKLIST}" \
      /title="${SERVER_TITLE}" \
      /servername="${SERVER_NAME}"
    echo "TrackManiaServer exited, restarting in 15 seconds..."
    sleep 15
  done
}

# run services
run_tmserver &
wait