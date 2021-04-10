FROM circleci/android:api-29-node

RUN sudo apt install bash
RUN sudo useradd -ms /bin/bash mike
RUN sudo usermod mike -d /home/mike/

WORKDIR /home/mike
USER mike
ENV PATH $PATH:/home/mike/flutter/bin/

RUN git clone https://github.com/flutter/flutter.git -b stable

CMD ["bash"]