FROM         python:3
RUN          mkdir /app
WORKDIR      /app
ADD          ./ /app/
RUN          pip3 install -r requirements.txt
ENTRYPOINT   ["uwsgi","--ini", "payment.ini"]