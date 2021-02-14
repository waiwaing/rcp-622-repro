#!/bin/bash

# compress
rm "channel.zip"
zip -FS -r "channel.zip" .

# deploy
curl -sS -X POST http://192.168.1.89:8060/keypress/Home
response=$(curl -f -s -S --user "rokudev:rokudev" --anyauth -F "mysubmit=Install" -F "archive=@channel.zip" -F "passwd=" http://192.168.1.89/plugin_install |  grep -Po '(?<=<font color="red">).*' | sed 's/<\/font>//')

echo $response
if [[ $response == *"Failure"* ]]; then
    exit 1
fi
