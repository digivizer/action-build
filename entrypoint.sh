#!/bin/sh
echo "Building"
export CONVOX_RACK=$INPUT_RACK
SHORT_SHA=$(echo "${GITHUB_SHA}" | cut -c1-8)
BRANCH=$(echo ${GITHUB_REF} | sed -e "s/refs\/heads\///g" | sed -e "s/\//-/g")
DESCRIPTION="${GITHUB_ACTOR} ${BRANCH}#${SHORT_SHA} ${COMMIT_MESSAGE}"
echo $DESCRIPTION
release=$(convox build --description "${DESCRIPTION}" --app $INPUT_APP --id)
if [ -z "$release" ]
then
  echo "Build failed"
  exit 1
fi
echo ::set-output name=release::$release
echo "RELEASE=$release" >> $GITHUB_ENV
