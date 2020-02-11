#!/bin/sh
echo "Building"
export CONVOX_RACK=$INPUT_RACK
DESCRIPTION="${GITHUB_RUN_ID}:${GITHUB_RUN_NUMBER} ${GITHUB_SHA} ${GITHUB_ACTOR}\n${GITHUB_SHA}"
echo $DESCRIPTION
release=$(cd backend && convox build --description $DESCRIPTION --app $INPUT_APP --id)
if [ -z "$release" ]
then
  echo "Build failed"
  exit 1
fi
echo ::set-output name=release::$release
echo ::set-env name=RELEASE::$release
