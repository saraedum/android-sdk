FROM thyrlian/android-sdk:2.0

MAINTAINER Julian Rüth <julian.rueth@fsfe.org>

# work around https://github.com/gradle/gradle/issues/3117
RUN locale-gen "en_US.UTF-8"
ADD pam-environment /root/.pam-environment

# tools to build Android apps
RUN echo y | sdkmanager "build-tools;27.0.1"
# to build against the latest version
RUN echo y | sdkmanager "platforms;android-27"

# Install x86 emulator support (requires /dev/kvm and VMX in the docker container)
RUN wget --quiet --output-document=/android-wait-for-emulator https://raw.githubusercontent.com/travis-ci/travis-cookbooks/0f497eb71291b52a703143c5cd63a217c8766dc9/community-cookbooks/android-sdk/files/default/android-wait-for-emulator
RUN chmod +x /android-wait-for-emulator
RUN echo y | sdkmanager "emulator"
RUN echo y | sdkmanager "system-images;android-25;google_apis;x86"
# includes adb and such
RUN echo y | sdkmanager "platform-tools"
