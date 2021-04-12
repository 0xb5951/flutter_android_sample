#todo:imageをDistrolessに変更する
FROM ubuntu:20.04 as builder

# ENV Setup
ENV DEBIAN_FRONTEND=noninteractive

# Install Package
RUN apt update
RUN apt install -y curl git unzip xz-utils zip libglu1-mesa wget openjdk-8-jdk

# Setup new user
RUN useradd -ms /bin/bash mike
USER mike
WORKDIR /home/mike

# Setup Android-sdk
RUN mkdir -p Android/sdk
RUN mkdir -p .android && touch .android/repositories.cfg

RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv tools ./Android/sdk/

RUN cd Android/sdk/tools/bin && yes | ./sdkmanager --licenses
RUN cd Android/sdk/tools/bin && ./sdkmanager "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"
ENV PATH "$PATH:/home/mike/Android/sdk/platform-tools"

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git -b stable
ENV PATH $PATH:/home/mike/flutter/bin/
RUN flutter precache
RUN flutter config --enable-web

CMD ["bash"]