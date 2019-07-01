FROM beyondspider/jenkins:latest
MAINTAINER from www.beyondspider.com by admin (admin@beyondspider.com)

RUN npm -g install cordova @quasar/cli && \
	mkdir -p /opt/android/sdk && \
	mkdir -p /opt/android/gradle

ADD https://download.beyondspider.com/docker/sdk-tools-linux-4333796.zip /tmp/sdk-tools-linux-4333796.zip
ADD https://download.beyondspider.com/docker/build-tools-28.0.3.tar.gz /tmp/build-tools-28.0.3.tar.gz
ADD https://download.beyondspider.com/docker/platforms-android-28.tar.gz /tmp/platforms-android-28.tar.gz
ADD https://download.beyondspider.com/docker/platform-tools-29.0.1.tar.gz /tmp/platform-tools-29.0.1.tar.gz
ADD https://download.beyondspider.com/docker/licenses.tar.gz /tmp/licenses.tar.gz
ADD https://download.beyondspider.com/docker/gradle-4.10.3-all.zip /opt/dist/gradle/gradle-4.10.3-all.zip

RUN unzip /tmp/sdk-tools-linux-4333796.zip -d /opt/android/sdk && \
	tar -xzvf /tmp/build-tools-28.0.3.tar.gz -C /opt/android/sdk && \
	tar -xzvf /tmp/platforms-android-28.tar.gz -C /opt/android/sdk && \
	tar -xzvf /tmp/platform-tools-29.0.1.tar.gz -C /opt/android/sdk && \
	tar -xzvf /tmp/licenses.tar.gz -C /opt/android/sdk && \
	rm -rf /tmp/sdk-tools-linux-4333796.zip && \
	rm -rf /tmp/build-tools-28.0.3.tar.gz && \
	rm -rf /tmp/platforms-android-28.tar.gz && \
	rm -rf /tmp/platform-tools-29.0.1.tar.gz && \
	rm -rf /tmp/licenses.tar.gz

ENV ANDROID_SDK_ROOT /opt/android/sdk
ENV ANDROID_HOME /opt/android/sdk
ENV CORDOVA_ANDROID_GRADLE_DISTRIBUTION_URL file:///opt/dist/gradle/gradle-4.10.3-all.zip
ENV PATH $ANDROID_SDK_ROOT/tools/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/build-tools/28.0.3:$PATH

#RUN yes | sdkmanager "build-tools;28.0.3" "platforms;android-28"

RUN echo "export $(cat /proc/1/environ |tr '\0' '\n' | xargs)" >> /etc/profile
