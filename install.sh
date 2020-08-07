#!bin/bash

# install pipenv
export PATH=$PATH:/home/user/.local/bin
pip install --upgrade pip

# pip install --user pipenv

# git clone dex-net packages and get into `dex-net`
git clone https://github.com/ssw0536/dex-net.git
cd dex-net
git checkout dex-net/docker

# active python virtualenv and install dependencies
# pipenv --python 2.7 --site-packages
# pipenv shell
pip install -r ./../basic_requirements.txt
pip install -r ./../advanced_requirements.txt

# install deps from source
mkdir deps
cd deps

# install SDFGen
git clone https://github.com/jeffmahler/SDFGen.git
cd SDFGen
sudo sh install.sh
cd ..

# install Boost.NumPy
git clone https://github.com/jeffmahler/Boost.NumPy.git
cd Boost.NumPy
sudo sh install.sh
cd ..

# install Openrave
# TODO: (fail --> try later)
# git clone https://github.com/jeffmahler/openrave.git
# cd openrave
# sudo sh install.sh
# cd ..

# git clone
git clone https://github.com/ssw0536/perception.git
git clone https://github.com/BerkeleyAutomation/perception.git
git clone https://github.com/ssw0536/gqcnn.git
git clone https://github.com/ssw0536/meshpy.git
git clone https://github.com/ssw0536/visualization.git

# autolab_core
cd autolab_core
git checkout 0.14.0
pip install -e .
cd ..

# perception
cd perception
git checkout dex-net/docker
pip install -e .
cd ..

# gqcnn
cd gqcnn
git checkout dex-net/docker
pip install -e .
cd ..

# meshpy
cd meshpy
git checkout dex-net/docker
pip install -e .
cd ../

# visualization
cd visualization
git checkout dex-net/docker # visualization:0.0.6
pip install -e .
cd ..

# get back to dex-net folder
cd ..
pip install -e .