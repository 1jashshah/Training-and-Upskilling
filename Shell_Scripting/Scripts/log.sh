#!/bin/bash

number=$RANDOM

echo "Random number: $number"

logger -p user.info "Random number generated: $number"
