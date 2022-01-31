# Tensorflow v2 + Nvidia CUDA (latest) Docker + GPU-Auto-Enables (if available) + Non-Root User + App Pattern environments

```
If [ you need a Tensorflow v2 + CUDA for your ML/DL Container ] \
   or \
   [ you just want to run your ML/DL code (not time in platforms) ]:
   Then [ this one may be for you ]
```

# Python 3 with no root access 
* A Python 3 base Container with `no root access` (except using `sudo ...` and you can remove it using `sudo apt-get remove sudo` to protect your Container). 

# Components:
* (**NEW**) `Auto detect & enable GPU/CUDA`
  * Auto detect HOST's GPU/CUDA to enable Container accessing GPU
* Python 3 base image + pyenv
* No root setup: using /home/developer 
  * It has sudo for dev phase usage. You can "sudo apt-get remove sudo" to finalize the product image.
  * Note, you should consult Docker security experts in how to secure your Container for your production use!)

# Build (`Do this first!`)
Due to Docker Hub not allowing free host of pre-built images, you have to make local build to use!
```
./build.sh
```

# Run (demo)
```
./run.sh
```

# Rapid App Development Container
1. Copy 'your python project files including 'requirements.txt' to './app' folder
2. Modify '.env' file about 'mapping host folder(s) into 'container's folder' that you application will use/access, e.g., /home/developer/workspace:
   * Important not to use quote for 'APP_RUN_CMD' value -- it will be interpreted as part of the command!
3. That's it. If you don't define 'APP_RUN_CMD' will find the first python code to run.
```
#### ---- DON'T use (double) quotes for the command! ----
#APP_RUN_CMD=node simple-server.js
#APP_RUN_CMD=python3 main.py
APP_RUN_CMD=

(... ignore all the lines before ...)
#VOLUMES_LIST="./data ./workspace
#PORTS_LIST="18808:8888"

```
### Examples of "#VOLUMES_LIST" and "#PORTS_LIST": (Remember only one # will be specally handled by ./run.sh to generate proper docker run command:
```
#### -------------------------------------------------------------
#### ---- Docker:Run:Specifications: Volumes Mapping: ----
#### -------------------------------------------------------------
##VOLUMES_LIST="./data:data ./workspace:workspace"
##VOLUMES_LIST="data workspace"
##VOLUMES_LIST="app data workspace /var/run/docker.sock:/var/run/docker.sock"
##VOLUMES_LIST="/var/run/docker.sock:/var/run/docker.sock app data workspace"
##VOLUMES_LIST="/run/dbus:/host/run/dbus ./data:data app:/home/developer/app workspace:workspace "
##VOLUMES_LIST="./app:app ./data:data ./workspace:workspace"
##VOLUMES_LIST="data workspace /dev/shm:/dev/shm /var/run/docker.sock:/var/run/docker.sock /tmp/.X11-unix:/tmp/.X11-unix"

#### -------------------------------------------------------------
#### ---- Docker:Run:Specifications: Ports Mapping: ----
#### -------------------------------------------------------------
#### ---- You need to change to only 1 '#' to let "./run.sh" to interpret it.
##PORTS_LIST="18080:8000 17200:7200"
##PORTS_LIST="12781:12781"
##PORTS_LIST="1234:1234/udp"
##PORTS_LIST="8080:8080"
```
4. Build (./build.sh) and Run (./run.sh)

5. If you want enter container to do manual things:
```
./shell.sh
```

# Launch Jupyter Noteook
```
./shell.sh

(inside the container):
jupyter notebook

(then use yoru web browser)
http://0.0.0.0:18808/
(then provide token as shown on your console screen) to login
```

