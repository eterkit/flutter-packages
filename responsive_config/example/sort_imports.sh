#!/usr/bin/env bash

flutter pub run import_sorter:main
flutter format lib/* -l 80
flutter format test/* -l 80
