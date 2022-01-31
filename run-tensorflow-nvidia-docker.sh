#!/bin/bash -x

IMAGE_TAG=22.01
#docker pull nvcr.io/nvidia/tensorflow:${IMAGE_TAG}-tf2-py3
# nvcr.io/nvidia/tensorflow:21.12-tf2-py3
#docker run --gpus all -it --rm -v local_dir:container_dir nvcr.io/nvidia/tensorflow:${IMAGE_TAG}-tf2-py3
docker run --gpus all -it --rm -v $PWD/workspace:/workspace nvcr.io/nvidia/tensorflow:21.12-tf2-py3

