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

### Python

I normally use the system provided python3.

Since this is for ubuntu, I install the apt repo version of the following tools

If you want a version of python that is not yet in the repo, you have to add this PPA
`sudo add-apt-repository ppa:deadsnakes/ppa`

python source can also be downloaded, configured, and built locally
I followed the steps here: https://websiteforstudents.com/installing-the-latest-python-3-7-on-ubuntu-16-04-18-04/

* pip (python2)
* pip3 (python3)
* virtualenv (python2)

I install `virtualenvwrapper` globally
There is an argument to installing it locally `--user`

* virtualenvwrapper (python3)

```
sudo pip3 install virtualenvwrapper
```

If I need to use a version of python that is different from the system provided version.
I will install it under `/opt/python/` and use a virtulenv to specify it

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
  download and install deb
* emacs
  use ubuntu repo version
* intellij ?
  download and install to a local directory, add to PATH

## Markdown

* markdown
* grip

## Database clients

* dbeaver
  download deb

## Infrastructure tools

### Docker

* docker
* docker-compose

I install the docker-ce (community edition) as per ubuntu repo

#### Images
Use docker hub to download the images as needed

Popular Images:

* postgres
* mysql
* mongo
* redis

### nginx

install the ubunut repo version

