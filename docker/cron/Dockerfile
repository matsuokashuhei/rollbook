FROM python:3.7-stretch

RUN apt-get update && apt-get -y install cron postgresql-client-9.6
RUN pip install awscli

RUN mkdir /backup

COPY crontab /etc/cron.d/rollbook
RUN chmod 0644 /etc/cron.d/rollbook

ADD backup.sh /root/backup.sh
RUN chmod +x /root/backup.sh

COPY init.sh /root/init.sh
RUN chmod +x /root/init.sh

CMD /root/init.sh
