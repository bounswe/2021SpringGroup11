# pull official base image
FROM python:3.8.3-alpine

# set work directory
WORKDIR /usr/src/app

# set environment variables
# ENV PYTHONDONTWRITEBYTECODE 1
# ENV PYTHONUNBUFFERED 1

# install psycopg2 dependencies
# "Error: pg_config executable not found." this error occurs, probably due to alpine linux
RUN apk update
RUN apk add postgresql-dev gcc python3-dev musl-dev

# install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install -r requirements.txt

# copy project
COPY . /usr/src/app/
RUN python manage.py makemigrations
RUN python manage.py migrate
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
