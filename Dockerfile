FROM beyondspider/cordova-resource:latest as cordova-resource

FROM beyondspider/jenkins:latest

MAINTAINER from www.beyondspider.com by admin (admin@beyondspider.com)

COPY --from=cordova-resource /tmp/download/sdk-tools-linux-4333796.zip /tmp/sdk-tools-linux-4333796.zip
COPY --from=cordova-resource /tmp/download/build-tools-28.0.3.tar.gz /tmp/build-tools-28.0.3.tar.gz
COPY --from=cordova-resource /tmp/download/platforms-android-28.tar.gz /tmp/platforms-android-28.tar.gz
COPY --from=cordova-resource /tmp/download/platform-tools-29.0.1.tar.gz /tmp/platform-tools-29.0.1.tar.gz
COPY --from=cordova-resource /tmp/download/licenses.tar.gz /tmp/licenses.tar.gz
COPY --from=cordova-resource /tmp/download/gradle-4.10.3-all.zip /opt/dist/gradle/gradle-4.10.3-all.zip

RUN npm -g install cordova @quasar/cli && \
	mkdir -p /opt/android/sdk && \
	mkdir -p /opt/android/gradle && \
    unzip /tmp/sdk-tools-linux-4333796.zip -d /opt/android/sdk && \
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
