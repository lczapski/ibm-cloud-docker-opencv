# Dockerfile for example whisk docker action
FROM python:2-alpine3.6

# Upgrade and install basic Python dependencies
RUN apk add --no-cache bash \
 && apk add --no-cache --virtual .build-deps \
        bzip2-dev \
        gcc \
        libc-dev \
  && pip install --no-cache-dir gevent==1.1.2 flask==0.11.1 \
  && apk del .build-deps

ENV FLASK_PROXY_PORT 8080

RUN mkdir -p /actionProxy
ADD actionProxy/actionproxy.py /actionProxy/actionproxy.py 

ADD exec /action/exec
RUN chmod +x /action/exec

RUN apk add --no-cache --virtual .build-deps \
        bzip2-dev \
        gcc \
        libc-dev 	


RUN echo -e '@edgunity http://nl.alpinelinux.org/alpine/edge/community\n\
@edge http://nl.alpinelinux.org/alpine/edge/main\n\
@testing http://nl.alpinelinux.org/alpine/edge/testing\n\
@community http://dl-cdn.alpinelinux.org/alpine/edge/community'\
  >> /etc/apk/repositories

RUN apk update && apk upgrade

RUN apk add --update --no-cache \
  # --virtual .build-deps \
      build-base \
      openblas-dev \
      unzip \
      wget \
      cmake \

      #Intel® TBB, a widely used C++ template library for task parallelism'
      libtbb@testing  \
      libtbb-dev@testing   \

      # Wrapper for libjpeg-turbo
      libjpeg  \

      # accelerated baseline JPEG compression and decompression library
      libjpeg-turbo-dev \

      # Portable Network Graphics library
      libpng-dev \

      # A software-based implementation of the codec specified in the emerging JPEG-2000 Part-1 standard (development files)
      jasper-dev \

      # Provides support for the Tag Image File Format or TIFF (development files)
      tiff-dev \

      # Libraries for working with WebP images (development files)
      libwebp-dev \

      # A C language family front-end for LLVM (development files)
      clang-dev \

      linux-headers \
	  
	  curl \
	  
	  jq \
	  
	  jsoncpp \

      && pip install numpy

ENV CC /usr/bin/clang
ENV CXX /usr/bin/clang++

RUN mkdir /opt && cd /opt && \
  wget https://github.com/opencv/opencv/archive/3.3.0.zip && \
  unzip 3.3.0.zip && \
  cd /opt/opencv-3.3.0 && \
  mkdir build && \
  cd build && \
  cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_FFMPEG=NO \
  -D WITH_IPP=NO -D WITH_OPENEXR=NO .. && \
  make VERBOSE=1 && \
  make && \
  make install

RUN rm -rf /var/cache/apk/*		

CMD ["/bin/bash", "-c", "cd actionProxy && python -u actionproxy.py"]