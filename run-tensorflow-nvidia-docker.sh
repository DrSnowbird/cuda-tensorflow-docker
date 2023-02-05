#!/bin/bash -x

IMAGE_TAG=23.01
docker pull nvcr.io/nvidia/tensorflow:${IMAGE_TAG}-tf2-py3
# nvcr.io/nvidia/tensorflow:23.01-tf2-py3
docker run --gpus all -it --rm -v $PWD/workspace:/workspace nvcr.io/nvidia/tensorflow:${IMAGE_TAG}-tf2-py3

