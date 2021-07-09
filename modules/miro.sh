#!/usr/bin/env bash

if ! which miro > /dev/null; then
    snap install miro --edge
fi
