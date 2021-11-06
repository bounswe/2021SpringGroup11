## How to run

* `python3 -m venv env`
* `source env/bin/activate`
* `pip install -r requirements.txt`
* `cd api`
* `cp .env-template.yaml .env.yaml`
* _In this stage, put_ `SECRET_KEY: 'Your_Secret_Key'` _in the_ `.env.yaml`
* `python manage.py runserver 8000`
