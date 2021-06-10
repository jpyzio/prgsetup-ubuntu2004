#!/usr/bin/env bash

if ! which subl > /dev/null; then
    curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
    add-apt-repository "deb https://download.sublimetext.com/ apt/stable/"

    apt install -y sublime-text
fi
