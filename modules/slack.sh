#!/usr/bin/env bash

if ! which slack > /dev/null; then
    snap install slack --classic
fi
