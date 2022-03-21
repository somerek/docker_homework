#!/bin/sh
sleep 2
python manage.py migrate
DJANGO_SUPERUSER_PASSWORD="$1" python manage.py createsuperuser \
    --no-input --username="admin" --email="user@aol.com"
python manage.py loaddata catalog/fixtures/bbk_data.json
python manage.py runserver 0.0.0.0:8000
