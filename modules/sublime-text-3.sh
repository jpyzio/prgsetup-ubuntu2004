#!/usr/bin/env bash

which subl > /dev/null
if [[ "${?}" == "1" ]]; then
    sudo snap install sublime-text --classic
fi