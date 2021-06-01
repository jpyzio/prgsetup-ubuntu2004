#!/bin/bash
set -x
ps aux | grep -vE '(grep|bash)' | grep spotify > /dev/null

if [[ "${?}" == "1" ]]; then
    spotify &
fi

if [[ "${1}" == "play" ]]; then
	dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause > /dev/null

elif [[ "${1}" == "previous" ]]; then
	dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous > /dev/null

elif [[ "${1}" == "next" ]]; then
	dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next > /dev/null
fi
