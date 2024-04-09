ARG BASE
FROM ${BASE}

RUN apt-get update && apt-get install -y python3 python3-pip



ARG FLASK_VERSION
#RUN python3 -m venv /venv && \
#      /venv/bin/pip install Flask==${FLASK_VERSION}

RUN python3 -m pip install Flask==${FLASK_VERSION}


ENV FLASK_ENV=production
ENV PYTHONUNBUFFERED=1

COPY lib ./lib

CMD python3 lib/server.py

