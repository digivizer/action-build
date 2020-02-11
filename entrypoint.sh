#!/bin/sh
echo "Building"
export CONVOX_RACK=$INPUT_RACK
SHORT_SHA=$(echo "${GITHUB_SHA}" | cut -c1-6)
TAGS=$(echo ${GITHUB_REF} | sed -e "s/refs\/tags\///g")
BRANCH=$(echo ${GITHUB_REF} | sed -e "s/refs\/heads\///g" | sed -e "s/\//-/g")
DESCRIPTION="${BRANCH}#${SHORT_SHA} ${TAGS} - ${GITHUB_ACTOR}"
echo $DESCRIPTION
release=$(cd backend && convox build --description $DESCRIPTION --app $INPUT_APP --id)
if [ -z "$release" ]
then
  echo "Build failed"
  exit 1
fi
echo ::set-output name=release::$release
echo ::set-env name=RELEASE::$release
