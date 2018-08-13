# From node 8.11.3 based on Alpine Linux
FROM node:8.11.3-alpine

# Maintainer
MAINTAINER Abel Moreno <abel.moreno.acevedo@gmail.com>

# Install basics
RUN apk update &&  \ 
	apk add wget && \
    npm install -g ionic@latest && \
    npm install sass && \
	cd / && \
	ionic start frontend sidemenu 


# Install java
RUN apk update
RUN apk fetch openjdk8
RUN apk add openjdk8
ENV JAVA_HOME="/usr/lib/jvm/java-1.8-openjdk"
ENV PATH=$JAVA_HOME/bin:$PATH


# Install Android SDK
ENV VERSION_SDK_TOOLS=3952940 \
	ANDROID_HOME=/usr/local/android-sdk-linux

ENV	PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

RUN mkdir -p $ANDROID_HOME && \
    chown -R root.root $ANDROID_HOME && \
	# Install dependencies
	apk add --no-cache bash curl git openssl openssh-client ca-certificates && \
	# Install Android SDK

	wget -q -O sdk.zip http://dl.google.com/android/repository/sdk-tools-linux-$VERSION_SDK_TOOLS.zip && \
	unzip sdk.zip -d $ANDROID_HOME && \
	rm -f sdk.zip
	# Install and update Android packages

ADD packages.txt $ANDROID_HOME

RUN mkdir -p /root/.android && \
    touch /root/.android/repositories.cfg && \
	sdkmanager --update && yes | sdkmanager --licenses && \
	sdkmanager --package_file=$ANDROID_HOME/packages.txt


# Install Gradle
ENV GRADLE_VERSION 2.12
ENV GRADLE_HOME /usr/local/gradle
ENV PATH ${PATH}:${GRADLE_HOME}/bin
ENV GRADLE_USER_HOME /gradle

# Install gradle
WORKDIR /usr/local
RUN wget  https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip && \
    unzip gradle-$GRADLE_VERSION-bin.zip && \
    rm -f gradle-$GRADLE_VERSION-bin.zip && \
    ln -s gradle-$GRADLE_VERSION gradle && \
    echo -ne "- with Gradle $GRADLE_VERSION\n" >> /root/.built

RUN apk update && apk add libstdc++ && rm -rf /var/cache/apk/*

RUN npm install -g cordova
RUN cordova telemetry on


WORKDIR /frontend
EXPOSE 8100 35729