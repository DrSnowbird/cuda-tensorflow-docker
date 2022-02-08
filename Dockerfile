ARG IMAGE_TAG=21.12
ARG BASE=${BASE:-nvcr.io/nvidia/tensorflow:${IMAGE_TAG}-tf2-py3}
#docker pull nvcr.io/nvidia/tensorflow:${IMAGE_TAG}-tf2-py3
#ARG BASE=${BASE:-openkbs/python-nonroot-docker}
FROM ${BASE}


MAINTAINER DrSnowbird "DrSnowbird@openkbs.org"


ENV DEBIAN_FRONTEND noninteractive

#### ------------------------------------------------------------------------
#### ---- User setup so we don't use root as user ----
#### ------------------------------------------------------------------------
ENV USER_ID=${USER_ID:-1000}

ENV GROUP_ID=${GROUP_ID:-1000}
    
ENV USER=${USER:-developer}
ENV HOME=/home/${USER}

ENV LANG C.UTF-8
RUN apt-get update && apt-get install -y --no-install-recommends sudo curl vim git ack wget unzip ca-certificates && \
    useradd -ms /bin/bash ${USER} && \
    export uid=${USER_ID} gid=${GROUP_ID} && \
    mkdir -p /home/${USER} && \
    mkdir -p /etc/sudoers.d && \
    echo "${USER}:x:${USER_ID}:${GROUP_ID}:${USER},,,:/home/${USER}:/bin/bash" >> /etc/passwd && \
    echo "${USER}:x:${USER_ID}:" >> /etc/group && \
    echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER} && \
    chmod 0440 /etc/sudoers.d/${USER} && \
    chown -R ${USER}:${USER} /home/${USER} && \
    apt-get autoremove; \
    rm -rf /var/lib/apt/lists/* && \
    echo "vm.max_map_count=262144" | tee -a /etc/sysctl.conf

###############################
#### ---- App: (ENV)  ---- ####
###############################
USER ${USER:-developer}
WORKDIR ${HOME:-/home/developer}

ENV APP_HOME=${APP_HOME:-$HOME/app}
ENV APP_MAIN=${APP_MAIN:-setup.sh}

#################################
#### ---- App: (common) ---- ####
################################
WORKDIR ${APP_HOME}
RUN python -u -m pip install --upgrade pip

###############################
#### ---- App Setup:  ---- ####
###############################
COPY --chown=$USER:$USER ./app $HOME/app
COPY --chown=$USER:$USER ./bin $HOME/bin
RUN $HOME/bin/pre-load-virtualenv.sh && \
    if [ -s $HOME/app/requirements.txt ]; then \
        pip install --no-cache-dir --user -r requirements.txt ; \
    fi; 
    
#########################################
##### ---- Setup: Entry Files  ---- #####
#########################################
COPY --chown=${USER}:${USER} docker-entrypoint.sh /
COPY --chown=${USER}:${USER} ${APP_MAIN} ${HOME}/setup.sh
RUN sudo chmod +x /docker-entrypoint.sh ${HOME}/setup.sh && \
    sudo chown -R $USER:$USER $HOME/app

#########################################
##### ---- Docker Entrypoint : ---- #####
#########################################
ENTRYPOINT ["/docker-entrypoint.sh"]

#####################################
##### ---- user: developer ---- #####
#####################################
WORKDIR ${APP_HOME}
USER ${USER}

#############################################
#############################################
#### ---- App: (Customization here) ---- ####
#############################################
#############################################
#### (you customization code here!) #########

######################
#### (Test only) #####
######################
#CMD ["/bin/bash"]
######################
#### (RUN setup) #####
######################
CMD ["${HOME}/setup.sh"]

