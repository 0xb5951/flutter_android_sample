#todo:imageをDistrolessに変更する
FROM circleci/android:api-30-node

# Install Package
RUN sudo apt update && \
    sudo apt install -y curl git unzip bash curl file zip fontconfig ttf-dejavu x11-apps libpulse0 libnss3 libxcomposite-dev libasound-dev \
    qemu qemu-kvm libvirt-daemon libvirt-clients bridge-utils

WORKDIR /workdir
RUN sudo chmod 777 /workdir
RUN usermod -s /bin/bash circleci

RUN sdkmanager "cmdline-tools;latest" && \
    sdkmanager "system-images;android-31;google_apis;x86_64"

RUN avdmanager create avd --name test_1 -d 23 -k "system-images;android-31;google_apis;x86_64"

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git -b stable
ENV PATH $PATH:/workdir/flutter/bin/
RUN flutter precache
RUN yes | flutter doctor --android-licenses && flutter doctor

RUN sudo groupadd -r kvm && sudo adduser circleci kvm
COPY ./shell/.bash_profile /home/circleci/.bash_profile

CMD ["bash"]