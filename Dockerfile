#todo:imageをDistrolessに変更する
FROM circleci/android:api-30-node

# Install Package
RUN sudo apt update && \
    sudo apt install -y git bash curl file x11-apps libpulse0 libnss3 libxcomposite-dev libasound-dev \
    qemu qemu-kvm libvirt-daemon libvirt-clients bridge-utils

# basic setting
WORKDIR /workdir
COPY ./shell/run_second_startup.sh ./run_second_startup.sh
RUN usermod -s /bin/bash circleci
RUN sudo groupadd -r kvm && sudo adduser circleci kvm \
    && sudo chmod 777 . \
    && sudo chmod 777 ./run_second_startup.sh 

# setup emulator
RUN sdkmanager "cmdline-tools;latest" && \
    sdkmanager "system-images;android-31;google_apis;x86_64"
RUN avdmanager create avd --name pixel_android_31_x86_64 -d "pixel_3a" -k "system-images;android-31;google_apis;x86_64"

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git -b stable && sudo mv ./flutter/ /opt/
ENV PATH $PATH:/opt/flutter/bin/
RUN flutter precache
RUN yes | flutter doctor --android-licenses && flutter doctor

ENTRYPOINT [ "bash", "./run_second_startup.sh" ]
