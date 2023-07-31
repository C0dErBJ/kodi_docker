FROM ubuntu:16.04

WORKDIR /root
RUN apt-get update
RUN apt-get install -y autoconf bison build-essential curl default-jdk flex gawk git gperf lib32stdc++6 lib32z1 lib32z1-dev libcurl4-openssl-dev unzip zip zlib1g-dev
RUN apt-get install -y wget software-properties-common
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update
RUN apt-get install -y openjdk-11-jdk
RUN wget -O /root/commandlinetools-linux.zip https://dl.google.com/android/repository/commandlinetools-linux-6200805_latest.zip
RUN wget -O /root/android-ndk.zip https://dl.google.com/android/repository/android-ndk-r21e-linux-x86_64.zip?hl=zh-cn

RUN mkdir -p /root/android-tools/android-sdk-linux
RUN unzip /root/commandlinetools-linux.zip -d /root/android-tools/android-sdk-linux/
RUN unzip /root/android-ndk.zip -d /root/android-tools

WORKDIR /root/android-tools/android-sdk-linux/tools/bin
CMD /bin/sh -c '/bin/echo -e "y\ny\ny\ny\n"| ./sdkmanager  --sdk_root=/root/android-tools/android-sdk-linux/tools/bin/../.. --licenses'
CMD ./sdkmanager  --sdk_root=/root/android-tools/android-sdk-linux/tools/bin/../.. platform-tools
CMD ./sdkmanager  --sdk_root=/root/android-tools/android-sdk-linux/tools/bin/../.. "platforms;android-33"
CMD ./sdkmanager  --sdk_root=/root/android-tools/android-sdk-linux/tools/bin/../.. "build-tools;30.0.3"

RUN mkdir -p ~/.android/
RUN keytool -genkey -keystore ~/.android/debug.keystore -v -alias androiddebugkey -dname "CN=Android Debug,O=Android,C=US" -keypass android -storepass android -keyalg RSA -keysize 2048 -validity 10000
RUN mkdir -p ~/src/
RUN apt-get install -y git
WORKDIR /root/src/
RUN git clone https://github.com/xbmc/xbmc kodi
WORKDIR /root/src/kodi

RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt update
RUN apt install g++-7 -y
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 60 --slave /usr/bin/g++ g++ /usr/bin/g++-7
RUN update-alternatives --config gcc
RUN apt install adb -y



