# Engineering

Software and tools that I install for my engineering tasks

## Programming Languages

* Go
* Python
* Java
* Javascript (node)

### Go

Download the binary from their website
https://golang.org/dl/
and install it under `/opt/go`

Add the go toolchain to path.
Add gopath to path

install gopls

### Python

I normally use the system provided python3.
Since this is for ubuntu, I install the apt repo version of the following tools
If you want a version of python that is not yet in the repo, you have to add this PPA
`sudo add-apt-repository ppa:deadsnakes/ppa`
python source can also be downloaded and built locally

#### Python3 pip requirements

The below packages should be installed to the user.
The user .local/bin should be added to the path

* pip3 install --user autopep8
* pip3 install --user flake8
* pip3 install --user pylint
* pip3 install --user pyls
* pip3 install --user virtualenvwrapper

### Java

I download the openjdk from the website and install it to `/opt/java`

I also download and install gradle and install it to `/opt/gradle`

### Javascript

Install nvm (node version manager) as per the instructions here
https://github.com/nvm-sh/nvm

Then run the following command to the latest stable version of node
```
nvm install node
```

## Code Editors and IDEs

* vscode
* emacs

* intellij
* android-studio

## Infrastructure tools

### docker

* docker
* docker-compose

I install the docker-ce (community edition) as per ubuntu repo

#### images
Use docker hub to download the images as needed

Popular Images:

* postgres
* mysql
* mongo
* redis

### nginx

install the ubuntu repo version

