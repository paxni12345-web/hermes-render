#!/bin/sh
# Source profile to get PATH
[ -f /etc/profile ] && . /etc/profile
[ -f ~/.profile ] && . ~/.profile

# Try full path first, fallback to PATH
if [ -x /usr/local/bin/hermes ]; then
    exec /usr/local/bin/hermes dashboard --host 0.0.0.0 --port 10000
elif [ -x /usr/bin/hermes ]; then
    exec /usr/bin/hermes dashboard --host 0.0.0.0 --port 10000
else
    exec hermes dashboard --host 0.0.0.0 --port 10000
fi
