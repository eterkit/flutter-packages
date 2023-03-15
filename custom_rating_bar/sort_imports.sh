#!/usr/bin/env bash

fvm flutter pub run import_sorter:main
fvm dart format lib/* -l 80
fvm dart format test/* -l 80
