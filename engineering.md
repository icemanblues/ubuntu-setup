# Engineering

Software and tools that I install for my engineering tasks

## Programming Languages

* Go
* Rust
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
install dlv

```
go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest
```

### Rust 

Download and install `rustup`

confirm rustc, cargo, rustfmt

install rls rust-analysis rust-src

```
rustup component add rls rust-analysis rust-src rustfmt
```


#### Rust Analyzer 

This is a different language server than rls. Many consider it better.

Follow these steps to install it. Rustup doesn't support it at this time.
However, it will be added to rustup in the near future

```
curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux -o ~/.local/bin/rust-analyzer
```

### Python

I normally use the system provided python3.
Since this is for ubuntu, I install the apt repo version of the following tools
If you want a version of python that is not yet in the repo, you have to add this PPA
`sudo add-apt-repository ppa:deadsnakes/ppa`
python source can also be downloaded and built locally

#### Python3 pip requirements

The below packages should be installed to the user.
The user .local/bin should be added to the path

```
pip3 install --user python-lsp-server mypy-ls ptvsd
pip3 install --user python-lsp-server mypy-ls ptvsd --upgrade
```

Optional: These packages are very helpful development tools. They provide static analysis for python.

```
pip3 install --user mypy autopep8 pylint flake8
pip3 install --user mypy autopep8 pylint flake8 --upgrade
```

And all in one line

```
python -m pip install --user python-lsp-server mypy-ls ptvsd mypy autopep8 pylint flake8 --upgrade
```

### Java

I download the openjdk from the website and install it to `/opt/java`

I also download and install gradle and install it to `/opt/gradle`

### Javascript

Install nvm (node version manager) as per the instructions here
https://github.com/nvm-sh/nvm

Then run the following command to the latest stable version of node
```
nvm install stable
```

Then use npm to globally install these must haves

* typescript

* pyright
* typescript-language-server
* dockerfile-language-server-nodejs

```
npm up typescript typescript-language-server dockerfile-language-server-nodejs -g
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

install the repo version

