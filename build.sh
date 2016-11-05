#!/bin/sh

build_type=$1
build_dir="./build_linux/"
lib_dir="./lib/"
bin_dir="./bin/"
if [ ! -d $build_dir ]; then
	mkdir $build_dir
fi
cd $build_dir
GENERATOR="Unix Makefiles"
if [ "$build_type"x = "debug"x ]; then
	build_opt="-DCMAKE_BUILD_TYPE=Debug"
elif [ "$build_type"x = "release"x ]; then
	build_opt="-DCMAKE_BUILD_TYPE=Release"
else
	echo "please enter build type: debug or release"
	exit
fi
cmake ../cmake -Dprotobuf_BUILD_TESTS=OFF -G "$GENERATOR" $build_opt
make

cd ..
if [ ! -d $lib_dir ]; then
	mkdir $lib_dir
fi

if [ ! -d $bin_dir ]; then
	mkdir $bin_dir
fi

cp $build_dir/*.a $lib_dir
cp $build_dir/protoc $bin_dir
