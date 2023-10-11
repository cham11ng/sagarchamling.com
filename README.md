# sagarchamling.com

Welcome to my blogging website.

[![Deploy to Github Pages](https://github.com/cham11ng/sagarchamling.com/actions/workflows/deploy.yml/badge.svg)](https://github.com/cham11ng/sagarchamling.com/actions/workflows/deploy.yml)

## prerequisites

* Install Git
* Install Go
* Install Hugo - Make sure you install latest version of hugo(>=0.119.0).

## contributing

### setup and run

```bash
git clone git@github.com:cham11ng/sagarchamling.com

cd sagarchamling.com

git submodule update --init --recursive # clone submodule

git submodule update --remote --merge # update theme

hugo server
```

### adding blog

```bash
# Syntax
hugo new --kind blog blogs/<folder-name>/<blog-title>.md

# Example
hugo new --kind blog blogs/tech/how-i-setup-my-website.md
```

### adding folder

```bash
# Syntax
hugo new --kind folder blogs/<folder-name>/_index.md

# Example
hugo new --kind folder blogs/tech/index.md
```

## inspired from

Hugo [PaperMod](https://github.com/adityatelange/hugo-PaperMod/).
