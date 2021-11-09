FROM alpine:latest

RUN apk add --no-cache build-base \
                       cmake \
                       git \
                       linux-headers \
                       openssh \
                       perl \
                       tar \
                       wget

RUN git clone https://github.com/spcl/liblsb && \
    cd liblsb && \
    ./configure --with-mpi --enable-sync && \
    make -j $(nproc) && \
    make install

RUN wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.1.tar.bz2 && \
    tar -xjf openmpi-4.1.1.tar.bz2 && \
    cd openmpi-4.1.1 && \
    ./configure --enable-mpi-cxx && \
    make -j $(nproc) && \
    make install

RUN apk del git \
            linux-headers \
            perl \
            tar \
            wget
