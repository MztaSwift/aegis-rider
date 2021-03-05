FROM python:3.8.3-alpine

WORKDIR /usr/src/app

ENV PYTHONDONTWRITEBYTECODE 1

#pull official python image
FROM python:3.8.3-alpine

#set working directory
WORKDIR /usr/src/app/

#set env variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

#install psycopg2 dependencies(postgres)
RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev
RUN apk add --update gcc libc-dev linux-headers && rm -rf /var/cache/apk/*

#install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install -r requirements.txt

#copy entrypoint.sh
COPY ./entrypoint.sh .

#copy project
COPY . .

#run entrypoint.sh
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]