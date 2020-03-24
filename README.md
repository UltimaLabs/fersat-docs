# FERSAT ground segment documentation

## Built With

* [MkDocs](https://www.mkdocs.org/)
* [Material for MkDocs theme](https://squidfunk.github.io/mkdocs-material/)

## Getting Started

### Prerequisites

* [Docker](https://www.docker.com/)
* [Ansible](https://www.ansible.com/) for copying generated HTML to server

### Installing

Checkout the code:

```
$ git clone https://github.com/UltimaLabs/fersat-docs.git
```

### Development server, build, deploy

Start development server on [http://localhost:8000](http://localhost:8000):

```
./serve.sh
```

Build the docs:
```
./build.sh
```

Copy generated HTML documentation to a server:
```
./deploy.sh
```

## Help

* [Install Docker image with MkDocs, Material theme and the dependencies](https://squidfunk.github.io/mkdocs-material/getting-started/#alternative-using-docker)
* [Getting started with with MkDocs](https://www.mkdocs.org/#getting-started)
* [Getting started with MkDocs and Material theme](https://squidfunk.github.io/mkdocs-material/getting-started/)
* [Markdown - Cheat Sheet](https://www.markdownguide.org/cheat-sheet/)
* [Markdown - Basic Syntax](https://www.markdownguide.org/basic-syntax/)

