FROM python:3.11-slim

WORKDIR /code

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DISPLAY=:99

RUN apt-get update
RUN apt-get install -y curl gnupg npm
RUN npm install n -g
RUN n latest
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN apt-get install -y catdoc poppler-utils xvfb libxi6 libgconf-2-4 unzip graphviz-dev ghostscript python3-tk nodejs yarn unar 

COPY requirements.txt .

RUN pip install --no-warn-script-location --disable-pip-version-check --requirement requirements.txt \
	&& jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-matplotlib

EXPOSE 8888

CMD jupyter notebook --ip 0.0.0.0 --allow-root --NotebookApp.token='' --NotebookApp.password='' --no-browser .
