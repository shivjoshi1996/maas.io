FROM ubuntu:xenial

# System dependencies
RUN apt-get update && apt-get install --yes python3-pip

# Python dependencies
ENV LANG C.UTF-8
RUN pip3 install --upgrade pip

# Import code, install code dependencies
WORKDIR /srv
ADD . .
RUN pip install -r requirements.txt

# Set git commit ID
ARG COMMIT_ID
RUN test -n "${COMMIT_ID}"
RUN echo "${COMMIT_ID}" > version-info.txt

# Setup commands to run server
ENTRYPOINT ["talisker.gunicorn", "webapp.wsgi", "--access-logfile", "-", "--error-logfile", "-", "--bind"]
CMD ["0.0.0.0:80"]

