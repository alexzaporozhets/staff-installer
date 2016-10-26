FROM tutum/mongodb-backup

RUN apt-get update && \
    apt-get install -y cifs-utils && \
    apt-get -y autoremove && \
    apt-get clean

ADD run.sh /run.sh
