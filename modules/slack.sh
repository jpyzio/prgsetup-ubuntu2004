#!/usr/bin/env bash

which slack > /dev/null
if [[ "${?}" == "1" ]]; then
  sudo snap install slack --classic
fi