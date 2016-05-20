FROM resin/armv7hf-debian-qemu
MAINTAINER Yury Bilenkis <adm@bilenkis.ru>

COPY opencv /usr/src/

RUN set -xe \
    && DEBIAN_FRONTEND=noninteractive \
    && BUILDDEPS="git make cmake libjpeg-dev libtiff5-dev libjasper-dev libgtk2.0-dev libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libdc1394-22-dev libxine2-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libqt4-dev"
    && apt-get update -qq  \
    # install dependencies
    && apt-get install -qq \
        $BUILDDEPS \ 

    # compile opencv with modules
    && cd /usr/src \
    && OPENCVSRC="opencv" \
    && mkdir $OPENCVSRC/build \
    && cd $OPENCVSRC/build \
    && cmake -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
            -D CMAKE_BUILD_TYPE=RELEASE \
            -D WITH_TBB=ON \
            -D BUILD_NEW_PYTHON_SUPPORT=ON \
            -D WITH_V4L=ON \
            -D INSTALL_PYTHON_EXAMPLES=ON \
            -D BUILD_EXAMPLES=ON \
            -D WITH_OPENGL=ON \
            .. \
    && make -j$(nproc)\
    && make install \
    && cd .. \
    && rm -rf build \
    && apt-get purge -qq $BUILDDEPS && apt-get autoremove -qq && apt-get clean
