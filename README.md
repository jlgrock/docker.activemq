# Introduction

Dockerfile to build an ActiveMQ Message Broker container image.

ActiveMQ is embeddable and highly available. Currently this image acts as a stand-alone container in single-node availability.

## Version

Current Version: **5.9.0**

# Hardware Requirements

## Memory

- **1GB** is the **standard** memory size. You should up that for production according to your needs.

## Storage

- Mostly, ActiveMQ stores things in memory, so no space is needed.  Should you start to persist to disk, consider attaching a data volume.

# How to get the image

You can either download the image from a docker registry or build it yourself.

## Building the Image

To build the image:
* Update the VERSION file
* Run the command `build.sh`

## Downloading from a Docker Registry

Pull the image from the docker index. This is the recommended method of installation as it is easier to update image. These builds are performed by the **Docker Trusted Build** service.

```bash
docker pull jlgrock/activemq:$VERSION
```

# Examples of Running a Container

You can launch the image using the docker command line :

- **For test purpose :**

```bash
docker run --name='activemq' -it --rm -P jlgrock/activemq:latest
```
The account admin is "admin" and password is "admin". All settings is the default ActiveMQ's settings.

- **For production purpose :**

```bash
docker run --name='activemq' -d \
-e 'ACTIVEMQ_NAME=amqp-srv1' \
-e 'ACTIVEMQ_REMOVE_DEFAULT_ACCOUNT=true' \
-e 'ACTIVEMQ_ADMIN_LOGIN=admin' -e 'ACTIVEMQ_ADMIN_PASSWORD=your_password' \
-e 'ACTIVEMQ_WRITE_LOGIN=producer_login' -e 'ACTIVEMQ_WRITE_PASSWORD=producer_password' 
-e 'ACTIVEMQ_READ_LOGIN=consumer_login' -e 'ACTIVEMQ_READ_PASSWORD=consumer_password' \
-e 'ACTIVEMQ_JMX_LOGIN=jmx_login' -e 'ACTIVEMQ_JMX_PASSWORD=jmx_password' \
-e 'ACTIVEMQ_STATIC_TOPICS=topic1;topic2;topic3' 
-e 'ACTIVEMQ_STATIC_QUEUES=queue1;queue2;queue3' \
-e 'ACTIVEMQ_MIN_MEMORY=1024' -e  'ACTIVEMQ_MAX_MEMORY=4096' \
-e 'ACTIVEMQ_ENABLED_SCHEDULER=true' \
-v /data/activemq:/data/activemq \
-v /var/log/activemq:/var/log/activemq \
-p 8161:8161 \
-p 61616:61616 \
-p 61613:61613 \
jlgrock/activemq:5.12.0
```

## Avaible Configuration Parameters

*Please refer the docker run command options for the `--env-file` flag where you can specify all required environment variables in a single file. This will save you from writing a potentially long docker run command.*

Below is the complete list of available options that can be used to customize your installation.

- **ACTIVEMQ_NAME**: The hostname of ActiveMQ server. Default to `localhost`
- **ACTIVEMQ_LOGLEVEL**: The log level. Default to `INFO`
- **ACTIVEMQ_PENDING_MESSAGE_LIMIT**: It is used to prevent slow topic consumers to block producers and affect other consumers by limiting the number of messages that are retained. Default to `1000`
- **ACTIVEMQ_STORAGE_USAGE**: The maximum amount of space storage the broker will use before disabling caching and/or slowing down producers. Default to `100 gb`
- **ACTIVEMQ_TEMP_USAGE**: The maximum amount of space temp the broker will use before disabling caching and/or slowing down producers. Default to `50 gb`
- **ACTIVEMQ_MAX_CONNECTION**: It's DOS protection. It limit concurrent connections. Default to `1000`
- **ACTIVEMQ_FRAME_SIZE**: It's DOS protection. It limit the frame size. Default to `104857600` (100MB)
- **ACTIVEMQ_ENABLED_SCHEDULER**: Permit to enabled scheduler in ActiveMQ
- **ACTIVEMQ_MIN_MEMORY**: The init memory in MB that ActiveMQ take when start (it's like XMS). Default to `128` (128 MB)
- **ACTIVEMQ_MAX_MEMORY**: The max memory in MB that ActiveMQ can take (it's like XMX). Default to `1024` (1024 MB)

- **ACTIVEMQ_REMOVE_DEFAULT_ACCOUNT**: It's permit to remove all default login on ActiveMQ (Webconsole, broker and JMX). Default to `false`
- **ACTIVEMQ_ADMIN_LOGIN**: The login for admin account (broker and web console). Default to `admin` 
- **ACTIVEMQ_ADMIN_PASSWORD**: The password for admin account. Default to `admin`
- **ACTIVEMQ_USER_LOGIN**: The login to access on web console with user role (no right on broker). Default to `user`
- **ACTIVEMQ_USER_PASSWORD**: The password for user account. Default to `user`
- **ACTIVEMQ_READ_LOGIN**: The login to access with read only role on all queues and topics.
- **ACTIVEMQ_READ_PASSWORD**: The password for read account.
- **ACTIVEMQ_WRITE_LOGIN**: The login to access with write role on all queues and topics.
- **ACTIVEMQ_WRITE_PASSWORD**: The password for write account.
- **ACTIVEMQ_OWNER_LOGIN**: The login to access with admin role on all queues and topics.
- **ACTIVEMQ_OWNER_PASSWORD**: The password for owner account.
- **ACTIVEMQ_JMX_LOGIN**: The login to access with read / write role on JMX. Default to `admin`
- **ACTIVEMQ_JMX_PASSWORD**: The password for JMX account. Default to `activemq`

- **ACTIVEMQ_STATIC_TOPICS**: The list of topics separated by comma witch is created when ActiveMQ start.
- **ACTIVEMQ_STATIC_QUEUES**: The list of queues separated by comma witch is created when ActiveMQ start.


## Advance configuration

For advance configuration, the best way is to read ActiveMQ documentation and created your own setting file like activemq.xml.
Next, you can mount it when you run this image or you can create your own image (base on this image) and include your specifics config file.

The home of ActiveMQ is in /opt/activemq, so if you want to override all the setting, you can launch docker with ` -v /your_path/conf:/opt/activemq/conf`



