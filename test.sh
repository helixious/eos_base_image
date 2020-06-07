#!/bin/bash
touch config.txt && grep -qxF $HOSTNAME config.txt || echo $HOSTNAME >> config.txt