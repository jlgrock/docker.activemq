FROM jlgrock/centos-oraclejdk:6.6-8u45
MAINTAINER Justin Grant <jlgrock@gmail.com>


# install necessary packages
# expectation is that update has been completed
# and curl/wget are already installed
RUN yum install -y python-setuptools \
	python-setuptools-devel && \
	easy_install pip && \
	easy_install -U distribute && \
	pip install supervisor

RUN yum install -y logrotate && \
	yum install -y cronie
 # && \
 #    yum install -y locales && \
 #    update-locale LANG=C.UTF-8 LC_MESSAGES=POSIX && \
 #    locale-gen en_US.UTF-8 && \
 #    dpkg-reconfigure locales

# Copy the app setting
COPY assets/init.py /app/init.py
RUN chmod 755 /app/init.py

RUN mkdir -p /etc/supervisor/conf.d /var/log/supervisor 
ADD assets/supervisord.conf /etc/supervisor/supervisord.conf

# Lauch app install
COPY assets/setup/ /app/setup/
RUN chmod 755 /app/setup/install
RUN /app/setup/install

# Expose ports - Openwire/TCP, Jetty, ActiveMQ, STOMP, MQTT, WS
EXPOSE 61616 8161 5672 61613 1883 61614

# Create Mount points.  This data will be lost unless you mount a volume with the -v or -volumes-from
VOLUME ["/data/activemq"]
VOLUME ["/var/log/activemq"]
VOLUME ["/opt/activemq/conf"]

#WORKDIR /opt/activemq

#ENTRYPOINT ["/app/init"]
CMD ["/app/init.py", "start"]

