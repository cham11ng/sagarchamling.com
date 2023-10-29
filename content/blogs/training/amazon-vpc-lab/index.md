---
title: 'Amazon Virtual Private Cloud (VPC) Lab'
summary: 'Explore and create custom VPC and deploy EC2 instance in VPC'
description: 'Explore and create custom VPC and deploy EC2 instance in VPC'
date: '2023-10-28'
tags: ['aws vpc', 'security groups', 'subnet', 'route table', 'network gateway']
hiddenInHomeList: true
cover:
  relative: true
  image: 'img/cover.webp'
  alt: 'Cover'
  hidden: false
---

## Objective

Amazon VPC is web service that allows us to create a private network in the cloud. In this lab,

- Part 1: Deploy VPC with public subnets
- Part 2: Deploy an EC2 instance into VPC

## Lab Begins

### Part 1: Exploration

#### VPC

Amazon Virtual Private Cloud is a virtual network that is dedicated to your AWS account

![Exploring VPC](img/vpc.webp)

> Note: The VPC IPv4 CIDR is `172.31.0.0/16`

#### Subnets

A subnet is a sub-range of IP addresses in the VPC.

![Exploring Subnets](img/subnets.webp)

> Note: Auto-assign public IPv4 address is **Yes**. The Subnet IPv4 CIDR is `172.31.0.0/20`. Since, AWS reserves **five** addresses in each subnet for it's own purpose such that only `4091` address are available out of `4096`.

#### Internet Gateway

An internet gateway allows communication between the resources in a VPC and the internet.

![Internet Gateway](img/internet-gateway.webp)

#### Route Table

A route table contains a set of rules, called routes, that are used to determine where network traffic is directed.

![Route Table](img/route-table.webp)

> Note: `172.31.0.0/16` is routed locally, allowing all subnets in a VPC to communicate with each other and all public traffic (`0.0.0.0/0`) is routed to the internet gateway.

![Subnet Associations](img/subnet-association.webp)

#### Security Group

A security group acts as a virtual firewall for instances to control inbound and outbound traffic.

##### Inbound Rules

![Inbound Rules](img/sg-inbound.webp)

##### Outbound Rules

![Outbound Rules](img/sg-outbound.webp)

##### Custom Security Group Inbound Rules

![Custom Security Group Inbound Rules](img/custom-sg-inbound.webp)

#### EC2 instance's VPC and Subnet

##### Exploring EC2 Instance

![Exploring EC2 Instance](img/ec2-explore.webp)

##### Navigating Public IP

![Navigating Public IP](img/ec2-navigate.webp)

### Part 2: Creation

#### Custom VPC

##### VPC CIDR

![VPC CIDR](img/vpc-cidr.webp)

##### VPC Subnets

![VPC Subnets](img/vpc-subnet.webp)

##### VPC Preview

![VPC Preview](img/vpc-preview.webp)

##### VPC Create

![VPC Create](img/vpc-create.webp)

##### VPC Page Navigate

![VPC Page Navigate](img/vpc-navigate.webp)

#### Custom Security Group

##### Security Group Create

![Security Group Create](img/sg-create.webp)

##### Security Group Page Navigate

![Security Group Page Navigate](img/sg-navigate.webp)

#### EC2 Instance in Custom VPC

##### EC2 AMI

![Launching instance in VPC](img/ec2-ami.webp)

##### EC2 Network Setting

![EC2 Network Setting](img/ec2-network.webp)

##### EC2 User Data

![EC2 User Data](img/ec2-user-data.webp)

The End
