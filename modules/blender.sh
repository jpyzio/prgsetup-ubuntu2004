#!/usr/bin/env bash

if ! which blender > /dev/null; then
    snap install blender --classic
fi
