
SRC=https://github.com/bminor/glibc/archive/refs/tags/

function download() {
    local version=$1
    local url=$SRC/$version.tar.gz
    local file=$(basename $url)
    if [ ! -f $file ]; then
        wget $url
    fi
    tar -xzf $file
}

function build() {
    local version=$1

    download $version

    local dir=glibc-$version
    cd $dir
    mkdir build
    cd build
    ../configure --disable-werror --prefix=$(pwd)/out
    make -j32 || exit 239
    cd ../..
}


#build glibc-2.38
build glibc-2.37
build glibc-2.36
build glibc-2.35
build glibc-2.34
build glibc-2.33
build glibc-2.33
build glibc-2.32
build glibc-2.31
build glibc-2.30

build glibc-2.29
build glibc-2.28
build glibc-2.27
