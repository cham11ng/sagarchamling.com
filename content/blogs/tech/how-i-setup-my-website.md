---
title: How I Setup My Website
summary: Step by Step Guide for setting up a personal website
description: Step by Step Guide for setting up a personal website
date: 2023-10-09T23:10:19-04:00
draft: false
tags: []
---

In this step-by-step guide, I'll walk you through the process of setting up your personal blog site using Hugo, a popular static site generator written in Go, and the PaperMod theme.

Along with that, I'll also show you how I configured my domain and hosting for this site. By the end of this tutorial, you'll have your blog up and running and ready to share your thoughts with the world.

---

## Step 0: Identify Purpose

I wanted a site that is super easy to maintain and configure, additionally should be fast and secure. My purpose is to own a personal site, centralize all my writing contents and showcase my work all together all in one place. My requirements were pretty simple that leds me select the static site generator.

## Step 1: Static Site Generator with `hugo`

Comparing Gatsby vs Hugo, JS vs Go, "Generated websites are super fast" vs "Lightning fast". According to my personal website idea, it doesn't require a dynamic contents or any user interactions which is purely based on static architecture. I selected hugo over Gatsby.

### Install Go, Hugo

The first step is to install Go and Hugo on your local machine. You can follow the installation instructions for your specific operating system [here](https://gohugo.io/getting-started/installing/).

> Please refer to the relevant documentation for installation instructions:
>
> - Git
> - Go
> - Dart Sass

### Create a New Hugo Site

Once Hugo is installed, create a new Hugo site using the following command:

```bash
hugo new site sagarchamling.com
```

Replace `sagarchamling.com` with the desired name of your blog.

## Step 2: Choosing Theme

Hugo offers a wide range of themes. Find your choice and make sure you give them a credit.

![regular](../images/hugo-themes.jpg)

### Install the PaperMod Theme

For my blog, I'll use the PaperMod theme. To install it, navigate to your theme's github page [here](https://github.com/adityatelange/hugo-PaperMod/wiki/Installation) and run:

```bash
git init # Initialize your git repository

git submodule add --depth=1 https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod
```

Next, open your blog's `config.toml` file and set the `theme` parameter to `"PaperMod"`.
or
You can take a reference of [exampleSite](https://github.com/adityatelange/hugo-PaperMod/tree/exampleSite) to begin with.

## Step 3: Customize Your Site

### Customizing theme css

```sh
.(site root)
├── content/
├── theme/PaperMod/
└── assets/
    └── css/
        └── extended/         <---
            ├── custom.css    <---
            └── any_name.css  <---

```

### Customizing header and footer partials

```sh
.(site root)
├── config.yml
├── content/
├── theme/hugo-PaperMod/
└── layouts
    ├── partials
    │   ├── extend_footer.html <---
    │   └── extend_head.html   <---
    └── robots.txt

```

### Create Content

Create your blog posts in the `content` directory. You can use Markdown to format your posts. For example, to create a new post, run:

```bash
hugo new blogs/my-first-post.md
```

Edit the Markdown file to write your content.

## Step 4: Deploy in Github Pages

### Setup Repository

Create repository in GitHub and add the remote origin.

```bash
git remote add origin git@github.com/cham11ng/sagarchamling.com
```

### Create a `.gitignore` file

Create a `.gitignore` file to exclude unnecessary files from version control. Here's a sample `.gitignore` for Hugo sites:

```
/resources/
/public/
/themes/
*.log
*.swp
```

### Commit and Push to GitHub

Commit your changes and push your blog to a GitHub repository:

```bash
git add .
git commit -m "Initial commit"
git remote add origin <your-github-repo-url>
git push -u origin master
```

## Step 5: Select Domain Name

### Choose a Domain Registrar

For your blog's domain name, consider using a domain registrar like [Porkbun](https://porkbun.com) or any other domain registrar of your choice. Search for available domain names, and once you find one that suits your blog, register it.

## Step 6: Configure and Publish Site

### Configure GitHub Pages

In your GitHub repository, go to the "Settings" tab and scroll down to the "GitHub Pages" section. Choose the "master branch" as your source, and GitHub will provide you with a URL for your published site.

### Configure Domain

In your domain registrar's dashboard (Porkbun in this case), configure your domain's DNS settings to point to GitHub Pages. This typically involves setting up a CNAME record with the GitHub Pages URL provided earlier.

It may take some time for DNS changes to propagate. Once it's done, your blog will be accessible through your custom domain.

Congratulations! You've successfully set up your personal blog site using Hugo, customized it with the PaperMod theme, and published it with your own domain name. Now, you're ready to start sharing your thoughts and ideas with the world. Happy blogging!
