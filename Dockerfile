FROM dockerfile/ubuntu
MAINTAINER Boden Russell <bodenru@gmail.com>

ADD install_jumpgate.sh /tmp/install_jumpgate.sh
RUN chmod 777 /tmp/install_jumpgate.sh && /tmp/install_jumpgate.sh && rm /tmp/install_jumpgate.sh

EXPOSE 12710

CMD ["gunicorn", "jumpgate.wsgi:make_api()", "--bind=0.0.0.0:12710", "--timeout=600", "--access-logfile=/dev/null", "-w", "4"]
