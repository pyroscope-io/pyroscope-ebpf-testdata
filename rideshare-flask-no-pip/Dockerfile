ARG PYTHON_VERSION=3.9
FROM python:${PYTHON_VERSION}

ADD requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

ENV FLASK_ENV=development
ENV PYTHONUNBUFFERED=1

COPY lib ./lib
CMD [ "python", "lib/server.py" ]

