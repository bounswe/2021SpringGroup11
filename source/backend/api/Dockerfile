# pull official base image
FROM python:3.8.3-alpine

# set work directory
WORKDIR /app

# set environment variables
# ENV PYTHONDONTWRITEBYTECODE 1
# ENV PYTHONUNBUFFERED 1

# install psycopg2 dependencies
# "Error: pg_config executable not found." this error occurs, probably due to alpine linux
# RUN apk update
RUN apk add gcc python3-dev musl-dev

# install dependencies
# RUN pip install --upgrade pip
# COPY ./requirements.txt .

COPY requirements.txt requirements.txt
RUN python3 -m pip install --upgrade pip
RUN pip3 install -r requirements.txt

# copy project
COPY . .

#COPY docker-entrypoint.sh /entrypoint.sh
WORKDIR /app

CMD [ "/app/startup_script.sh" ]
#RUN nohup python manage.py runserver &
# RUN python manage.py migrate
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
