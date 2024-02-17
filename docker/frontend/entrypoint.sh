#!/bin/sh

export FRONT_USER_PASSWORD=""

cd /home/$FRONT_USER

cd $FRONT_PATH

if [ ! -d ${FRONT_PATH}/node_modules ]; then
    yarn install
fi

if [ "$FRONT_MODE" = "development" ]; then
    quasar dev -m $FRONT_TYPE
elif [ "$FRONT_MODE" = "build" ]; then
    quasar build -m $FRONT_TYPE
elif [ "$FRONT_MODE" = "test" ]; then
    yarn test:e2e:ci
