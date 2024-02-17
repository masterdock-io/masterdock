#!/bin/sh

export BACKEND_USER_PASSWORD=""

cd /home/$BACKEND_USER


cd $BACKEND_PATH
sudo pip install --no-cache-dir -r requirements.txt

cd app
if [ "$BACKEND_MODE" = "development" ]; then
    flask --app app run --host=0.0.0.0 --debug
elif [ "$BACKEND_MODE" = "production" ]; then
    gunicorn -w 1 -b 0.0.0.0:5000 app:app
else
    flask --app app run --host=0.0.0.0 --debug
fi