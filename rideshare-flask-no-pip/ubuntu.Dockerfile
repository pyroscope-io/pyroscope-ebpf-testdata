ARG BASE
FROM ${BASE}

RUN apt-get update && apt-get install -y python3 python3-pip

ADD requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

ENV FLASK_ENV=production
ENV PYTHONUNBUFFERED=1

COPY lib ./lib
CMD [ "python3", "lib/server.py" ]

