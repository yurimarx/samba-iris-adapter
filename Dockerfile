ARG IMAGE=intersystemsdc/irishealth-community
ARG IMAGE=intersystemsdc/iris-community
FROM $IMAGE

USER root
ENV DEBIAN_FRONTEND noninteractive
ENV TZ=Etc/UTC


# install libraries required ImageAI/OpenCV to process images and videos
RUN apt-get -y update \
    && apt-get -y install apt-utils \
    && apt-get install -y smbclient gcc python-dev-is-python3 libkrb5-dev \
    && apt-get install -y python3 \
    && apt-get install -y python3-pip   

# use pip3 (the python zpm) to install imageai and the imageai dependencies
RUN pip3 install --upgrade pip setuptools wheel
RUN pip3 install --target /usr/irissys/mgr/python smbprotocol

USER ${ISC_PACKAGE_MGRUSER}
WORKDIR /home/irisowner/irisbuild

ARG TESTS=0
ARG MODULE="samba-iris-adapter"
ARG NAMESPACE="USER"

RUN --mount=type=bind,src=.,dst=. \
    iris start IRIS && \
	iris session IRIS < iris.script && \
    ([ $TESTS -eq 0 ] || iris session iris -U $NAMESPACE "##class(%ZPM.PackageManager).Shell(\"test $MODULE -v -only\",1,1)") && \
    iris stop IRIS quietly
