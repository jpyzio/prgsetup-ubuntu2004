#!/usr/bin/env bash

if ! which subl > /dev/null; then
    snap install sublime-text --classic
fi
