---
title: Mission 2 Challenge
summary: Learning and Outcome from Mission 2 Challenge
description: Learning and Outcome from Mission 2 Challenge
date: 2023-10-18
slug: '/mission-2-challenge'
weight: 200
hiddenInHomeList: true
tags:
  [
    'kubernetes',
    'gke',
    'gcr',
    'aws',
    'google cloud',
    'sql',
    's3',
    'iam',
    'terraform',
    'multi-cloud',
    'cloud computing',
  ]
cover:
  relative: true
  image: 'img/architecture.webp'
  alt: 'Mission 2 Solution Architecture Cover'
  hidden: false
---

## Mission Introduction

In this mission, I have my Google Cloud SQL instance and Google Kubernetes Engine Cluster up and running from the previous Mission 1. Going further, I'll have to setup MySQL database, deploy image of application to Google Container Registry, deploy the app in cluster as GKE Workload. The main goal is deploy an app and make it publicly accessible.

### Inside

- Manager IAM user to provide programmatic access to AWS S3 Bucket from Google Kubernetes Cluster app.
- Manually setup user in SQL Cloud, create database and table which will be used by the application.
- Build and upload the docker image in GCR (Google Container Registry).
- Connect the previous made application cluster to Google Cloud Container cluster.
- Apply the application Kubernetes configuration to run upload GCR image in a cluster
- Once, the app is up and running we use the public IP address to access the application.

## Begin Hands-on Project

### User creation for Kubernetes cluster app to connect S3

![System User Creation](img/system-user.webp)

### Create user to access SQL Instance

![SQL Instance user account](img/sql-user.webp)

### Create table in mysql database

![SQL DB Setup](img/sql-db-setup.webp)

### Build Docker image and push it to GCR

![Successful Build](img/console-build.webp)

### Container Registry of App

![Container Registry Build](img/container-registry-build.webp)

### Connect to GKE cluster

![Connect luxxy cluster to GKE cluster](img/connect-to-cluster.webp)

## Mission Accomplished

### Deployed application in Cluster as Workload

![Kubernetes workloads](img/kubernetes-workload.webp)

### Browsing the application

![Browsing the application](img/running-server.webp)

## Invite to The Cloud Bootcamp

- https://e.thecloudbootcamp.com/d8z5zO
