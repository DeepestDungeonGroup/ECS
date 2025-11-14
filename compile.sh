#!/bin/bash
clear
if [[ $1 == "-re" ]]
then
    echo "------------RE-BUILD"------------
    rm -rf ./build/ ./*.a
    mkdir ./build/ && cd ./build/
    cmake ..
    cmake --build .
    cd ..
    echo "------------END------------"

elif [[ $1 == "-t" ]]
then
    echo ""------------DEBUG"------------"
    rm -rf ./build/ ./*.a
    mkdir ./build/ && cd ./build/
    cmake .. -DENABLE_TESTS=ON -DENABLE_COVERAGE=ON
    cmake --build .
    ctest --output-on-failure
    gcovr --root .. \
        --filter '../src/.*' \
        --filter '../include/.*' \
        --html --html-details -o coverage.html
    xdg-open coverage.html
    cd ..
    echo "------------END------------"

elif [[ $1 == "-d" ]]
then
    echo ""------------DEBUG"------------"
    rm -rf ./build/ ./*.a
    mkdir ./build/ && cd ./build/
    cmake .. -DCMAKE_BUILD_TYPE=Debug
    cmake --build . -v
    cd ..
    echo "------------END------------"

elif [[ $1 == "-c" ]]
then
    echo "------------CLEAR------------"
    rm -rf ./build/ ./*.a
    echo "------------END------------"

else
    echo "------------BUILD------------"
    if [ ! -d "./build/" ]
    then
        mkdir ./build/ && cd ./build/
        cmake ..
        cd ..
    else
        cmake --build ./build/
    fi
    echo "------------END------------"
fi
