#!/bin/sh
echo "Building"
export CONVOX_RACK=$INPUT_RACK
release=$(convox build --app $INPUT_APP --id)
if [ -z "$release" ]
then
  echo "Build failed"
  exit 1
fi
echo ::set-output name=release::$release
echo ::set-env name=RELEASE::$release
