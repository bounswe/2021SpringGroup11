How to run:
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
cd api
python manage.py runserver 8000
cp .env-template.yaml .env.yaml
