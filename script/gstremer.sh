#!/bin/bash

raspivid -t 0 -w 1280 -h 720 -fps 25 -b 15000000 -n -o - | gst-launch-1.0 -v fdsrc ! h264parse ! rtph264pay config-interval=1 pt=96 ! gdppay ! tcpserversink host=0.0.0.0 port=5000
