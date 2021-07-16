#todo:imageをDistrolessに変更する
FROM circleci/android:api-30-node

# Install Package
RUN sudo apt update && \
    sudo apt install -y curl git unzip bash curl file zip fontconfig ttf-dejavu oneko x11-apps

WORKDIR /workdir
RUN sudo chmod 777 /workdir
RUN usermod -s /bin/bash circleci

# RUN sdkmanager "cmdline-tools;latest"

# # Install Flutter
# RUN git clone https://github.com/flutter/flutter.git -b stable
# ENV PATH $PATH:/workdir/flutter/bin/
# RUN flutter precache
# RUN yes | flutter doctor --android-licenses && flutter doctor

CMD ["bash"]