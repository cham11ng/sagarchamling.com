# sagarchamling.com

Welcome to my personal website.

[![Deploy to Github Pages](https://github.com/cham11ng/sagarchamling.com/actions/workflows/deploy.yml/badge.svg)](https://github.com/cham11ng/sagarchamling.com/actions/workflows/deploy.yml)

## prerequisites

* Install Git - necessary for Method 1 & 2.
* Install Go
* Install Hugo - Make sure you install latest version of hugo(>=0.119.0).

## contributing

### setup and run

```bash
git clone git@github.com:cham11ng/sagarchamling.com

cd sagarchamling.com

git submodule update --init --recursive # Clone submodule

git submodule update --remote --merge # Update theme

hugo server
```

### adding blog

```bash
# Syntax
hugo new --kind post blogs/<folder-name>/<blog-title>.md

# Example
hugo new --kind post blogs/tech/how-i-setup-my-website.md
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
