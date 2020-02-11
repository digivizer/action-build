#!/bin/sh
echo "Building"
export CONVOX_RACK=$INPUT_RACK
echo $GITHUB_SHA:8
echo $GITHUB_SHA::8
DESCRIPTION="${GITHUB_RUN_ID}:${GITHUB_RUN_NUMBER} ${GITHUB_SHA:8} ${GITHUB_SHA::8} ${GITHUB_ACTOR}"
release=$(cd backend && convox build -d $DESCRIPTION --app $INPUT_APP --id)
if [ -z "$release" ]
then
  echo "Build failed"
  exit 1
fi
echo ::set-output name=release::$release
echo ::set-env name=RELEASE::$release
