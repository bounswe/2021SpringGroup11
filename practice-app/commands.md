
### env var
- copy .env.template
- change variables
- rename to `.env`

### virtual env
`python3 -m venv .venv`

`source .venv/bin/activate`

### pip
`pip install -r requirements.txt`

### migrate/setup database 
- `python3 manage.py makemigrations`
- `python3 manage.py migrate`

###  start new app
- `python3 manage.py startapp <your-app-name>`
- add your app name to mysite urls.py

###  run
`python3 manage.py runserver`
