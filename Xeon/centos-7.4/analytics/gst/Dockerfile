
FROM centos:7.4.1708 AS build
WORKDIR /home

# COMMON BUILD TOOLS
RUN yum install -y -q bzip2 make autoconf libtool git wget ca-certificates pkg-config gcc gcc-c++ bison flex patch epel-release yum-devel libcurl-devel zlib-devel;

# Install cmake
ARG CMAKE_VER=3.13.1
ARG CMAKE_REPO=https://cmake.org/files
RUN wget -O - ${CMAKE_REPO}/v${CMAKE_VER%.*}/cmake-${CMAKE_VER}.tar.gz | tar xz && \
    cd cmake-${CMAKE_VER} && \
    ./bootstrap --prefix="/usr/local" --system-curl && \
    make -j8 && \
    make install

# Install automake, use version 1.14 on CentOS
ARG AUTOMAKE_VER=1.14
ARG AUTOMAKE_REPO=https://ftp.gnu.org/pub/gnu/automake/automake-${AUTOMAKE_VER}.tar.xz
RUN wget -O - ${AUTOMAKE_REPO} | tar xJ && \
    cd automake-${AUTOMAKE_VER} && \
    ./configure --prefix=/usr --libdir=/usr/local/lib64 --disable-doc && \ 
    make -j8 && \
    make install

# Build NASM
ARG NASM_VER=2.13.03
ARG NASM_REPO=https://www.nasm.us/pub/nasm/releasebuilds/${NASM_VER}/nasm-${NASM_VER}.tar.bz2
RUN  wget ${NASM_REPO} && \
     tar -xaf nasm* && \
     cd nasm-${NASM_VER} && \
     ./autogen.sh && \
     ./configure --prefix="/usr/local" --libdir=/usr/local/lib64 && \
     make -j8 && \
     make install

# Build YASM
ARG YASM_VER=1.3.0
ARG YASM_REPO=https://www.tortall.net/projects/yasm/releases/yasm-${YASM_VER}.tar.gz
RUN  wget -O - ${YASM_REPO} | tar xz && \
     cd yasm-${YASM_VER} && \
     sed -i "s/) ytasm.*/)/" Makefile.in && \
     ./configure --prefix="/usr/local" --libdir=/usr/local/lib64 && \
     make -j8 && \
     make install

# Build ogg
ARG OGG_VER=1.3.3
ARG OGG_REPO=https://downloads.xiph.org/releases/ogg/libogg-${OGG_VER}.tar.xz

RUN wget -O - ${OGG_REPO} | tar xJ && \
    cd libogg-${OGG_VER} && \
    ./configure --prefix="/usr/local" --libdir=/usr/local/lib64 --enable-shared && \
    make -j8 && \
    make install DESTDIR=/home/build && \
    make install

# Build vorbis
ARG VORBIS_VER=1.3.6
ARG VORBIS_REPO=https://downloads.xiph.org/releases/vorbis/libvorbis-${VORBIS_VER}.tar.xz

RUN wget -O - ${VORBIS_REPO} | tar xJ && \
    cd libvorbis-${VORBIS_VER} && \
    export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib64 && \
    ./configure --prefix="/usr/local" --libdir=/usr/local/lib64 --enable-shared && \
    make -j8 && \
    make install DESTDIR=/home/build && \
    make install

# Build mp3lame
ARG MP3LAME_VER=3.100
ARG MP3LAME_REPO=https://sourceforge.net/projects/lame/files/lame/${MP3LAME_VER}/lame-${MP3LAME_VER}.tar.gz

RUN wget -O - ${MP3LAME_REPO} | tar xz && \
    cd lame-${MP3LAME_VER} && \
    ./configure --prefix="/usr/local" --libdir=/usr/local/lib64 --enable-shared --enable-nasm && \
    make -j8 && \
    make install DESTDIR=/home/build && \
    make install

# Build fdk-aac
ARG FDK_AAC_VER=v0.1.6
ARG FDK_AAC_REPO=https://github.com/mstorsjo/fdk-aac/archive/${FDK_AAC_VER}.tar.gz

RUN wget -O - ${FDK_AAC_REPO} | tar xz && mv fdk-aac-${FDK_AAC_VER#v} fdk-aac && \
    cd fdk-aac && \
    autoreconf -fiv && \
    ./configure --prefix="/usr/local" --libdir=/usr/local/lib64 --enable-shared && \
    make -j8 && \
    make install DESTDIR=/home/build && \
    make install


# Build opus
ARG OPUS_VER=1.2.1
ARG OPUS_REPO=https://archive.mozilla.org/pub/opus/opus-${OPUS_VER}.tar.gz

RUN wget -O - ${OPUS_REPO} | tar xz && \
    cd opus-${OPUS_VER} && \
    ./configure --prefix="/usr/local" --libdir=/usr/local/lib64 --enable-shared && \
    make -j8 && \
    make install DESTDIR=/home/build && \
    make install

# Build vpx
ARG VPX_VER=tags/v1.7.0
ARG VPX_REPO=https://chromium.googlesource.com/webm/libvpx.git

RUN git clone ${VPX_REPO} && \
    cd libvpx && \
    git checkout ${VPX_VER} && \
    ./configure --prefix="/usr/local" --libdir=/usr/local/lib64 --enable-shared --disable-examples --disable-unit-tests --enable-vp9-highbitdepth --as=nasm && \
    make -j8 && \
    make install DESTDIR=/home/build && \
    make install


# Build AOM
ARG AOM_VER=b6f1767eedbaddeb1ff5aa409a710ef61078640e
ARG AOM_REPO=https://aomedia.googlesource.com/aom

RUN  git clone ${AOM_REPO} && \
     mkdir aom/aom_build && \
     cd aom/aom_build && \
     git checkout ${AOM_VER} && \
     cmake -DBUILD_SHARED_LIBS=ON -DENABLE_NASM=ON -DENABLE_TESTS=OFF -DENABLE_DOCS=OFF -DCMAKE_INSTALL_PREFIX="/usr/local" -DCMAKE_INSTALL_LIBDIR=lib64 .. && \
     make -j8 && \
     make install DESTDIR="/home/build" && \
     make install

# Build x264
ARG X264_VER=stable
ARG X264_REPO=https://github.com/mirror/x264

RUN  git clone ${X264_REPO} && \
     cd x264 && \
     git checkout ${X264_VER} && \
     ./configure --prefix="/usr/local" --libdir=/usr/local/lib64 --enable-shared && \
     make -j8 && \
     make install DESTDIR="/home/build" && \
     make install


# Build x265
ARG X265_VER=2.9
ARG X265_REPO=https://github.com/videolan/x265/archive/${X265_VER}.tar.gz

RUN  yum install -y -q numactl-devel libpciaccess-devel

RUN  wget -O - ${X265_REPO} | tar xz && mv x265-${X265_VER} x265 && \
     cd x265/build/linux && \
     cmake -DBUILD_SHARED_LIBS=ON -DENABLE_TESTS=OFF -DCMAKE_INSTALL_PREFIX=/usr/local -DLIB_INSTALL_DIR=/usr/local/lib64 ../../source && \
     make -j8 && \
     make install DESTDIR="/home/build" && \
     make install

# Install required packges
RUN yum install -y ninja-build python36-setuptools

# Build Meson
ARG MESON_VER=0.53.1
ARG MESON_REPO=https://github.com/mesonbuild/meson

RUN git clone ${MESON_REPO}; \
    cd meson; \
    git checkout ${MESON_VER}; \
    python3.6 setup.py install;

# Build dav1d
ARG LIBDAV1D_VER=0.5.2
ARG LIBDAV1D_REPO=https://code.videolan.org/videolan/dav1d.git

RUN  git clone ${LIBDAV1D_REPO}; \
     cd dav1d; \
     git checkout ${LIBDAV1D_VER}; \
     meson build --prefix /usr --libdir /usr/lib64 --buildtype release; \
     ninja-build -C build; \
     cd build; \
     DESTDIR="/home/build" ninja-build install; \
     ninja-build install;


# Fetch SVT-HEVC
ARG SVT_HEVC_VER=v1.4.3
ARG SVT_HEVC_REPO=https://github.com/intel/SVT-HEVC

RUN yum install -y -q patch centos-release-scl && \
    yum install -y -q devtoolset-7

RUN git clone ${SVT_HEVC_REPO} && \
    cd SVT-HEVC/Build/linux && \
    export PKG_CONFIG_PATH="/usr/local/lib64/pkgconfig" && \
    git checkout ${SVT_HEVC_VER} && \
    mkdir -p ../../Bin/Release && \
    ( source /opt/rh/devtoolset-7/enable && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_INSTALL_LIBDIR=lib64 -DCMAKE_ASM_NASM_COMPILER=yasm ../.. && \
    make -j8 && \
    make install DESTDIR=/home/build && \
    make install )


# Fetch SVT-AV1
ARG SVT_AV1_VER=v0.8.1
ARG SVT_AV1_REPO=https://github.com/OpenVisualCloud/SVT-AV1

ARG SVT_AV1_PATCHES_RELEASE_VER=0.3
ARG SVT_AV1_PATCHES_RELEASE_URL=https://github.com/VCDP/CDN/archive/v${SVT_AV1_PATCHES_RELEASE_VER}.tar.gz
ARG SVT_AV1_PATCHES_PATH=/home/CDN-${SVT_AV1_PATCHES_RELEASE_VER}
RUN wget -O - ${SVT_AV1_PATCHES_RELEASE_URL} | tar xz

RUN git clone ${SVT_AV1_REPO} && \
    cd SVT-AV1 && \
    git checkout ${SVT_AV1_VER} && \
    find ${SVT_AV1_PATCHES_PATH}/SVT-AV1_patches -type f -name '*.patch' -print0 | sort -z | xargs -t -0 -n 1 patch -p1 -i && \
    cd Build/linux && \
    mkdir -p ../../Bin/Release && \
    ( source /opt/rh/devtoolset-7/enable && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_INSTALL_LIBDIR=lib64 -DCMAKE_ASM_NASM_COMPILER=yasm ../.. && \
    make -j8 && \
    make install DESTDIR=/home/build && \
    make install )

#Remove build residue from SVT-AV1 build -- temp fix for bug
RUN if [ -d "build/home/" ]; then rm -rf build/home/; fi


# Fetch SVT-VP9
ARG SVT_VP9_VER=v0.1.0
ARG SVT_VP9_REPO=https://github.com/OpenVisualCloud/SVT-VP9

RUN git clone ${SVT_VP9_REPO} && \
    cd SVT-VP9/Build/linux && \
    git checkout ${SVT_VP9_VER} && \
    mkdir -p ../../Bin/Release && \
  ( source /opt/rh/devtoolset-7/enable && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_INSTALL_LIBDIR=lib64 -DCMAKE_ASM_NASM_COMPILER=yasm ../.. && \
    make -j8 && \
    make install DESTDIR=/home/build && \
    make install )

# Build the gstreamer core
ARG GST_VER=1.16.0
ARG GST_REPO=https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-${GST_VER}.tar.xz

RUN  yum install -y -q glib2-devel-2.56.1 gettext-devel gobject-introspection gobject-introspection-devel python-gobject-base
RUN  wget -O - ${GST_REPO} | tar xJ && \
     cd gstreamer-${GST_VER} && \
     ./autogen.sh \
        --prefix=/usr/local \
        --libdir=/usr/local/lib64 \
        --libexecdir=/usr/local/lib64 \
        --enable-shared \
        --enable-introspection \
        --disable-examples \
        --disable-debug \
        --disable-benchmarks \
        --disable-gtk-doc && \
     make -j $(nproc) && \
     make install DESTDIR=/home/build && \
     make install;

# Build the gstremaer plugin bad set
ARG GST_ORC_VER=0.4.28
ARG GST_ORC_REPO=https://gstreamer.freedesktop.org/src/orc/orc-${GST_ORC_VER}.tar.xz

RUN  wget -O - ${GST_ORC_REPO} | tar xJ && \
     cd orc-${GST_ORC_VER} && \
     ./autogen.sh --prefix=/usr/local --libdir=/usr/local/lib64 \
                --libexecdir=/usr/local/lib64 \
                --enable-shared \
                --disable-examples --disable-debug \
                --disable-gtk-doc && \
     make -j $(nproc) && \
     make install DESTDIR=/home/build && \
     make install

# Build the gstremaer plugin base
ARG GST_PLUGIN_BASE_REPO=https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-${GST_VER}.tar.xz

RUN  yum install -y -q libXv-devel libvisual-devel libtheora-devel glib2-devel alsa-lib-devel cdparanoia-devel mesa-libGL-devel pango-devel

RUN  yum install -y -q libXrandr-devel


RUN  wget -O - ${GST_PLUGIN_BASE_REPO} | tar xJ && \
     cd gst-plugins-base-${GST_VER} && \
     export PKG_CONFIG_PATH="/usr/local/lib64/pkgconfig" && \
     ./autogen.sh \
        --prefix=/usr/local \
        --libdir=/usr/local/lib64 \
        --libexecdir=/usr/local/lib64 \
        --enable-introspection \
        --enable-shared \
        --disable-examples --disable-debug \
        --disable-gtk-doc && \
     make -j $(nproc) && \
     make install DESTDIR=/home/build && \
     make install


# Build the gstremaer plugin good set
ARG GST_PLUGIN_GOOD_REPO=https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-${GST_VER}.tar.xz

RUN  yum install -y -q libsoup-devel libjpeg-devel

RUN  wget -O - ${GST_PLUGIN_GOOD_REPO} | tar xJ && \
     cd gst-plugins-good-${GST_VER} && \
     export PKG_CONFIG_PATH="/usr/local/lib64/pkgconfig" && \
     ./autogen.sh \
        --prefix=/usr/local \
        --libdir=/usr/local/lib64 \
        --libexecdir=/usr/local/lib64 \
        --enable-shared \
        --disable-examples --disable-debug \
        --disable-gtk-doc && \
     make -j $(nproc) && \
     make install DESTDIR=/home/build && \
     make install


# Build the gstreamer plugin bad set
ARG GST_PLUGIN_BAD_REPO=https://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-${GST_VER}.tar.xz
ARG GST_PATCHES_RELEASE_VER=v0.1
ARG GST_PATCHES_RELEASE_URL=https://github.com/VCDP/gstreamer-patch/archive/${GST_PATCHES_RELEASE_VER}.tar.gz
RUN wget -O - ${GST_PATCHES_RELEASE_URL} | tar xz

RUN  yum localinstall -y --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm && yum install -y -q openssl-devel librtmp-devel && yum remove -y rpmfusion-free-release

RUN  wget -O - ${GST_PLUGIN_BAD_REPO} | tar xJ && \
     cd gst-plugins-bad-${GST_VER} && \
     export PKG_CONFIG_PATH="/usr/local/lib64/pkgconfig" && \
     find /home/gstreamer-patch-${GST_PATCHES_RELEASE_VER#*v}/ -type f -name '*.patch' -print0 | sort -z | xargs -t -0 -n 1 patch -p1 -i && \
     ./autogen.sh \
        --prefix=/usr/local \
        --libdir=/usr/local/lib64 \
        --libexecdir=/usr/local/lib64 \
        --enable-shared \
        --disable-examples --disable-debug \
        --disable-gtk-doc \ 
        --disable-shm \
        --disable-mxf && \
     make -j $(nproc) && \
     make install DESTDIR=/home/build && \
     make install

# Build the gstremaer plugin ugly set
ARG GST_PLUGIN_UGLY_REPO=https://gstreamer.freedesktop.org/src/gst-plugins-ugly/gst-plugins-ugly-${GST_VER}.tar.xz

RUN  wget -O - ${GST_PLUGIN_UGLY_REPO} | tar xJ; \
     cd gst-plugins-ugly-${GST_VER}; \
     export PKG_CONFIG_PATH="/usr/local/lib64/pkgconfig"; \
     ./autogen.sh \
        --prefix=/usr/local \
        --libdir=/usr/local/lib64 \
        --libexecdir=/usr/local/lib64 \
        --enable-shared \
        --disable-examples --disable-debug \
        --disable-gtk-doc && \
     make -j $(nproc) && \
     make install DESTDIR=/home/build && \
     make install

# Build gst-libav
ARG GST_PLUGIN_LIBAV_REPO=https://gstreamer.freedesktop.org/src/gst-libav/gst-libav-${GST_VER}.tar.xz

RUN yum install -y -q zlib-devel openssl-devel

RUN wget -O - ${GST_PLUGIN_LIBAV_REPO} | tar xJ && \
    cd gst-libav-${GST_VER} && \
    export PKG_CONFIG_PATH="/usr/local/lib64/pkgconfig" && \
    ./autogen.sh \
        --prefix="/usr/local" \
        --libdir=/usr/local/lib64 \
        --enable-shared \
        --enable-gpl \
        --disable-gtk-doc && \
    make -j $(nproc) && \
    make install DESTDIR=/home/build && \
    make install


# Build gstremaer plugin for svt

RUN cd SVT-HEVC/gstreamer-plugin && \
    export PKG_CONFIG_PATH="/usr/local/lib64/pkgconfig" && \
    cmake . && \
    make -j8 && \
    make install DESTDIR=/home/build && \
    make install

RUN cd SVT-VP9/gstreamer-plugin && \
    export PKG_CONFIG_PATH="/usr/local/lib64/pkgconfig" && \
    cmake . && \
    make -j8 && \
    make install DESTDIR=/home/build && \
    make install

RUN cd SVT-AV1/gstreamer-plugin && \
    export PKG_CONFIG_PATH="/usr/local/lib64/pkgconfig" && \
    cmake . && \
    make -j8 && \
    make install DESTDIR=/home/build && \
    make install

ARG OPENCV_VER=4.1.0
ARG OPENCV_REPO=https://github.com/opencv/opencv/archive/${OPENCV_VER}.tar.gz

RUN yum install -y -q eigen3-devel

RUN wget ${OPENCV_REPO} && \
    tar -zxvf ${OPENCV_VER}.tar.gz && \
    cd opencv-${OPENCV_VER} && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local -DOPENCV_GENERATE_PKGCONFIG=ON -DBUILD_EXAMPLES=OFF -DBUILD_PERF_TESTS=OFF -DBUILD_DOCS=OFF -DBUILD_TESTS=OFF .. && \
    make -j $(nproc) && \
    make install DESTDIR=/home/build && \
    make install


# Build DLDT-Inference Engine
ARG DLDT_VER=2020.1
ARG DLDT_REPO=https://github.com/opencv/dldt.git

RUN yum install -y -q boost-devel glibc-static glibc-devel libstdc++-static libstdc++-devel libstdc++ libgcc libusbx-devel openblas-devel;

RUN git clone -b ${DLDT_VER} ${DLDT_REPO} && \
    cd dldt && \
    git submodule update --init --recursive && \
    mkdir build && \
    cd build && \
    cmake  -DCMAKE_INSTALL_PREFIX=/opt/intel/dldt -DLIB_INSTALL_PATH=/opt/intel/dldt -DENABLE_MKL_DNN=ON -DENABLE_CLDNN=OFF -DENABLE_SAMPLES=OFF -DENABLE_OPENCV=OFF -DENABLE_TESTS=OFF -DENABLE_GNA=OFF -DENABLE_PROFILING_ITT=OFF -DENABLE_SAMPLES_CORE=OFF -DENABLE_SEGMENTATION_TESTS=OFF -DENABLE_OBJECT_DETECTION_TESTS=OFF -DBUILD_TESTS=OFF -DNGRAPH_UNIT_TEST_ENABLE=OFF -DNGRAPH_TEST_UTIL_ENABLE=OFF .. && \
    make -j $(nproc) && \
    rm -rf ../bin/intel64/Release/lib/libgtest* && \
    rm -rf ../bin/intel64/Release/lib/libgmock* && \
    rm -rf ../bin/intel64/Release/lib/libmock* && \
    rm -rf ../bin/intel64/Release/lib/libtest*

ARG libdir=/opt/intel/dldt/inference-engine/lib/intel64

RUN mkdir -p /opt/intel/dldt/inference-engine/include && \
    cp -r dldt/inference-engine/include/* /opt/intel/dldt/inference-engine/include && \
    mkdir -p ${libdir} && \
    cp -r dldt/bin/intel64/Release/lib/* ${libdir} && \
    mkdir -p /opt/intel/dldt/inference-engine/src && \
    cp -r dldt/inference-engine/src/* /opt/intel/dldt/inference-engine/src/ && \
    mkdir -p /opt/intel/dldt/inference-engine/share && \
    cp -r dldt/build/share/* /opt/intel/dldt/inference-engine/share/ && \
    mkdir -p /opt/intel/dldt/inference-engine/external/ && \
    cp -r dldt/inference-engine/temp/tbb /opt/intel/dldt/inference-engine/external/

RUN mkdir -p build/opt/intel/dldt/inference-engine/include && \
    cp -r dldt/inference-engine/include/* build/opt/intel/dldt/inference-engine/include && \
    mkdir -p build${libdir} && \
    cp -r dldt/bin/intel64/Release/lib/* build${libdir} && \
    mkdir -p build/opt/intel/dldt/inference-engine/src && \
    cp -r dldt/inference-engine/src/* build/opt/intel/dldt/inference-engine/src/ && \
    mkdir -p build/opt/intel/dldt/inference-engine/share && \
    cp -r dldt/build/share/* build/opt/intel/dldt/inference-engine/share/ && \
    mkdir -p build/opt/intel/dldt/inference-engine/external/ && \
    cp -r dldt/inference-engine/temp/tbb build/opt/intel/dldt/inference-engine/external/

RUN for p in /usr /home/build/usr /opt/intel/dldt/inference-engine /home/build/opt/intel/dldt/inference-engine; do \
        pkgconfiglibdir="$p/lib64" && \
        mkdir -p "${pkgconfiglibdir}/pkgconfig" && \
        pc="${pkgconfiglibdir}/pkgconfig/dldt.pc" && \
        echo "prefix=/opt" > "$pc" && \
        echo "libdir=${libdir}" >> "$pc" && \
        echo "includedir=/opt/intel/dldt/inference-engine/include" >> "$pc" && \
        echo "" >> "$pc" && \
        echo "Name: DLDT" >> "$pc" && \
        echo "Description: Intel Deep Learning Deployment Toolkit" >> "$pc" && \
        echo "Version: 5.0" >> "$pc" && \
        echo "" >> "$pc" && \
        echo "Libs: -L\${libdir} -linference_engine" >> "$pc" && \
        echo "Cflags: -I\${includedir}" >> "$pc"; \
    done;

ENV InferenceEngine_DIR=/opt/intel/dldt/inference-engine/share
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/intel/dldt/inference-engine/lib:/opt/intel/dldt/inference-engine/external/tbb/lib:${libdir}

# DLDT IE C API
ARG DLDT_C_API_REPO=https://raw.githubusercontent.com/VCDP/FFmpeg-patch/ffmpeg4.2_va/thirdparty/dldt-c-api/source/v2.0.1.tar.gz

ARG c_api_libdir="/usr/local/lib64"
RUN wget -O - ${DLDT_C_API_REPO} | tar xz && \
    cd dldt-c_api-2.0.1 && \
    mkdir -p build && cd build && \
    cmake -DENABLE_AVX512F=OFF .. && \
    make -j8 && \
    make install && \
    make install DESTDIR=/home/build
ENV PKG_CONFIG_PATH=${c_api_libdir}/pkgconfig:$PKG_CONFIG_PATH

#install Model Optimizer in the DLDT for Dev




RUN yum install -y -q glib2-devel gtk-dock openblas uuid-devel python3 python36-gobject-devel python3-devel

RUN yum install -y -q binutils uuid-devel

ARG PAHO_INSTALL=true
ARG PAHO_VER=1.3.0
ARG PAHO_REPO=https://github.com/eclipse/paho.mqtt.c/archive/v${PAHO_VER}.tar.gz
RUN if [ "$PAHO_INSTALL" = "true" ] ; then \
        wget -O - ${PAHO_REPO} | tar -xz && \
        cd paho.mqtt.c-${PAHO_VER} && \
        make && \
        make install && \
        cp build/output/libpaho-mqtt3c.so.1.0 /home/build/usr/local/lib64/ && \
        cp build/output/libpaho-mqtt3cs.so.1.0 /home/build/usr/local/lib64/ && \
        cp build/output/libpaho-mqtt3a.so.1.0 /home/build/usr/local/lib64/ && \
        cp build/output/libpaho-mqtt3as.so.1.0 /home/build/usr/local/lib64/ && \
        cp build/output/paho_c_version /home/build/usr/local/bin/ && \
        cp build/output/samples/paho_c_pub /home/build/usr/local/bin/ && \
        cp build/output/samples/paho_c_sub /home/build/usr/local/bin/ && \
        cp build/output/samples/paho_cs_pub /home/build/usr/local/bin/ && \
        cp build/output/samples/paho_cs_sub /home/build/usr/local/bin/ && \
        chmod 644 /home/build/usr/local/lib64/libpaho-mqtt3c.so.1.0 && \
        chmod 644 /home/build/usr/local/lib64/libpaho-mqtt3cs.so.1.0 && \
        chmod 644 /home/build/usr/local/lib64/libpaho-mqtt3a.so.1.0 && \
        chmod 644 /home/build/usr/local/lib64/libpaho-mqtt3as.so.1.0 && \
        ln /home/build/usr/local/lib64/libpaho-mqtt3c.so.1.0 /home/build/usr/local/lib64/libpaho-mqtt3c.so.1 && \
        ln /home/build/usr/local/lib64/libpaho-mqtt3cs.so.1.0 /home/build/usr/local/lib64/libpaho-mqtt3cs.so.1 && \
        ln /home/build/usr/local/lib64/libpaho-mqtt3a.so.1.0 /home/build/usr/local/lib64/libpaho-mqtt3a.so.1 && \
        ln /home/build/usr/local/lib64/libpaho-mqtt3as.so.1.0 /home/build/usr/local/lib64/libpaho-mqtt3as.so.1 && \
        ln /home/build/usr/local/lib64/libpaho-mqtt3c.so.1 /home/build/usr/local/lib64/libpaho-mqtt3c.so && \
        ln /home/build/usr/local/lib64/libpaho-mqtt3cs.so.1 /home/build/usr/local/lib64/libpaho-mqtt3cs.so && \
        ln /home/build/usr/local/lib64/libpaho-mqtt3a.so.1 /home/build/usr/local/lib64/libpaho-mqtt3a.so && \
        ln /home/build/usr/local/lib64/libpaho-mqtt3as.so.1 /home/build/usr/local/lib64/libpaho-mqtt3as.so && \
        cp src/MQTTAsync.h /home/build/usr/local/include/ && \
        cp src/MQTTClient.h /home/build/usr/local/include/ && \
        cp src/MQTTClientPersistence.h /home/build/usr/local/include/ && \
        cp src/MQTTProperties.h /home/build/usr/local/include/ && \
        cp src/MQTTReasonCodes.h /home/build/usr/local/include/ && \
        cp src/MQTTSubscribeOpts.h /home/build/usr/local/include/; \
    else \
        echo "PAHO install disabled"; \
    fi

# Build librdkafka
ARG LIBRDKAFKA_VER=1.0.0
ARG FILE_NAME=v${LIBRDKAFKA_VER}
ARG LIBRDKAFKA_REPO=https://github.com/edenhill/librdkafka/archive/${FILE_NAME}.tar.gz

RUN wget -O - ${LIBRDKAFKA_REPO} | tar xz && \
    cd librdkafka-${LIBRDKAFKA_VER} && \
    ./configure --prefix=/usr/local --libdir=/usr/local/lib64 && \
    make -j8 && \
    make install DESTDIR=/home/build && \
    make install;



#Install va gstreamer plugins

ARG VA_GSTREAMER_PLUGINS_VER=v0.7.0 
ARG VA_GSTREAMER_PLUGINS_REPO=https://github.com/opencv/gst-video-analytics

RUN git clone ${VA_GSTREAMER_PLUGINS_REPO} && \
    cd gst-video-analytics && \
    git checkout ${VA_GSTREAMER_PLUGINS_VER} && \
    git submodule init && git submodule update && \
    mkdir build && \
    cd build && \
    export CFLAGS="-std=gnu99 -Wno-missing-field-initializers" && \
    export CXXFLAGS="-std=c++11 -Wno-missing-field-initializers" && \
    cmake \
    -DVERSION_PATCH=$(echo "$(git rev-list --count --first-parent HEAD)") \
    -DGIT_INFO=$(echo "git_$(git rev-parse --short HEAD)") \
    -DCMAKE_BUILD_TYPE=Release \
    -DDISABLE_SAMPLES=ON \
    -DENABLE_PAHO_INSTALLATION=1 \
    -DENABLE_RDKAFKA_INSTALLATION=1 \
    -DHAVE_VAAPI=OFF  \
    -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=/usr/local .. && \
    make -j4
RUN mkdir -p build/usr/local/lib64/gstreamer-1.0 && \
    cp -r gst-video-analytics/build/intel64/Release/lib/* build/usr/local/lib64/gstreamer-1.0
RUN mkdir -p /usr/local/lib64/gstreamer-1.0 && \
    cp -r gst-video-analytics/build/intel64/Release/lib/* /usr/local/lib64/gstreamer-1.0

ENV GST_PLUGIN_PATH=${GST_PLUGIN_PATH}:/usr/local/lib64/gstreamer-1.0



# Clean up after build
RUN rm -rf /home/build/usr/include && \
    rm -rf /home/build/usr/share/doc && \
    rm -rf /home/build/usr/share/gtk-doc && \
    rm -rf /home/build/usr/share/man && \
    rm -rf /home/build/usr/local/include && \
    rm -rf /home/build/usr/local/share/doc && \
    rm -rf /home/build/usr/local/share/gtk-doc && \
    rm -rf /home/build/usr/local/share/man && \
    find /home/build -name "*.a" -exec rm -f {} \;

FROM centos:7.4.1708
LABEL Description="This is the image for DLDT and GSTREAMER on CentOS 7.4"
LABEL Vendor="Intel Corporation"
WORKDIR /home

# Prerequisites
RUN yum install -y epel-release;  \
    yum localinstall -y --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm; \
    yum install -y -q numactl openssl glib2-2.56.1 pango gobject-introspection libpng12 libXv libvisual mesa-libGL pango glib2 alsa-lib cdparanoia libtheora openblas-serial uuid python3 \
libsoup libjpeg-turbo librtmp ; \
    yum remove -y -q epel-release; \
    yum remove -y -q rpmfusion-free-release; \
    rm -rf /var/cache/yum/*;

# Install
COPY --from=build /home/build /
ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib:/usr/local/lib64
ARG libdir=/opt/intel/dldt/inference-engine/lib/intel64
ARG c_api_libdir="/usr/local/lib64"
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/intel/dldt/inference-engine/lib:/opt/intel/dldt/inference-engine/external/tbb/lib:${libdir}:${c_api_libdir}
ENV PKG_CONFIG_PATH=${c_api_libdir}/pkgconfig:$PKG_CONFIG_PATH
ENV InferenceEngine_DIR=/opt/intel/dldt/inference-engine/share
ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib64/gstreamer-1.0
ENV PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig
ENV LIBRARY_PATH=${LIBRARY_PATH}:/usr/local/lib:/usr/lib
ENV PATH=/usr/bin:${PATH}:/usr/local/bin
ENV GST_PLUGIN_PATH=${GST_PLUGIN_PATH}:/usr/local/lib64/gstreamer-1.0

