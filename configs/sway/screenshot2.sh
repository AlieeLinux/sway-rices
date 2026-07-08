#!/bin/bash

geom="$(slurp)" && sleep 3 && grim -t png -g "$geom" -c -l 0 - | swappy -f -
