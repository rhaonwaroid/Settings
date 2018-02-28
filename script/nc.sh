#!/bin/bash

raspivid -t 0 -w 1280 -h 720 -fps 25 -b 15000000 -n -o - | nc -l 5000
