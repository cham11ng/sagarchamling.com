---
title: 'Capture The Flag Competition Preparation Journey'
summary: 'Experience sharing, Cracking CTF preparation for competition'
description: 'Experience sharing, Cracking CTF preparation for competition'
slug: '/ctf-competition-preparation-journey'
date: '2023-10-19'
tags: ['capture the flag', 'cyberq', 'ec-council']
draft: true
---

> **Important Note**: Always follow ethical guidelines. Never use these skills for illegal activities.

## Familiarization

My preparation journey led me to platforms like **Hack The Box**, **TryHackMe**, and **CyberQ**, which offered a free tier for Capture the Flag scenarios and challenges, it helped me get started.

I began solving problems and gradually familiarized myself with the landscape of ethical hacking. I learned about _port scanning_ and _network discovery_ for **enumeration** as part of the **Reconnaissance** process. I also discovered various _misconfigurations_ that could potentially _bypass authentication_ for different network ports. In addition, I explored various methods for _password cracking_ and _privilege escalation_.

Understanding all the tools and techniques was challenging, so I began to compile reference notes. This not only helped me memorize a lot of information but also served as a handy guide. Refer [here]({{< catref "ethical-hacking" >}}).

## Building Mindset

CTF challenges and competitions can vary based on different cloud platforms. Here are a few simple points to help you start building a mindset for cracking CTFs:

### Enumeration

- Discover networks to find the IP address of active connections in the given network.
- Scan for open ports and look after each all possible service misconfigurations to bypass the authentication.
- Use a browser to explore the application or perform directory traversal to find unsecured hidden paths.

### Exploitation

- If password locking is an issue, there are many ways to perform use dictionary or brute force attacks to crack the password. Depending on the situation and target platform, decide which tools will be most effective for cracking password.
- Familiarize with the concept of reverse shell and tools that can generate the reverse shell file. This file can be injected into and redirected to the target computer’s shell, granting remote access.
- Once attacker get into the target system, there's a likelihood of misconfigurations. These can allow attacker to perform privilege escalation, potentially granting elevated access to resources.

## In Action

### Context

We were given a scenario with instructions and vulnerable cloud system in EC-Council's CyberQ platform. There were seven flags in total to capture, with the final one being the most challenging. Each flag was linked to the previous one, either directly or indirectly, and the seventh flag couldn’t be captured without finding the first six. I applied the same mindset that I had prepared mentioned in previous section. In this challenge, we had to demonstrate scanning network skills, password cracking skills, reverse shell and privilege escalation in a Linux based target system.

### The Pain

Unfortunately, many of us faced difficulties as the virtual machine (VM) provided for the competition was hosted on a server in **Singapore**. Accessing it from **North America** resulted in a slow server response, _keyboard input lag_, and _key bouncing_. The competitive environment was intense, which led to panic and frustration. However, staying calm and being patient was crucial. After a series of actions, I managed to capture all the flags in 38 minutes.

![CyberQ Result](img/result.webp)

> Pro Tip: To overcome the key bouncing issue, I typed commands in my system’s notepad and then copied them to the CyberQ VM using the **Paste Clipboard Text** button.

> Troubleshooting: **Reset** your VM, if you face black screen of death or any OS issue.

### Submission Tips

| Placeholder Pattern                | Description                                                        | Example                            |
| ---------------------------------- | ------------------------------------------------------------------ | ---------------------------------- |
| N, NN                              | Represents single or two digit numeric                             | 6, 22                              |
| aaaaaa                             | Represents all small alphabet of length 6                          | hannaa                             |
| aaaaaaaaaa-aaaaa-aaaaaa            | Represents small alphabets with exact length and hyphen in between | gracemedia-media-player            |
| NANNNNaaN.NaaNNaN-NNaNaNaNNNNNNNAN | Represents combination of alphabets and numbers                    | 1F6154fc2.7fa29a5-48c6a7b6902590E7 |

> Note: It is specific to CyberQ, even if you submit all your flags correctly, the time doesn't stop unless you **Ends/Terminates the running** by the VM using the **red power** button. Then, finish lab by clicking **Finish** button.
