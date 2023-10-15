---
title: Nmap Basics
summary: Nmap Basics
description: Nmap Basics
tags: []
draft: true
---

## Intro

`nmap` is Network Mapper

```bash
sudo nmap -p- <target-ip-addr> # Scan all ports, takes longer.
sudo nmap -sV <target-ip-addr> # Enable version detection, name and description of identified services.

# Note: Some of the scripts in this category are considered intrusive and
# should not be run against a target network without permission.
sudo nmap -sC <target-ip-addr> # Performs a script scan using the default set of scripts

nmap -A <target-ip-addr>
nmap -A -O -T4 --script=vuln <target-ip-addr>
```

| Options    | Description                                                                                                                                                                                                                     |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| -sC        | Performs a script scan using the default set of scripts. It is equivalent to --script=default. Some of the scripts in this category are considered intrusive and should not be run against a target network without permission. |
| -sV        | Enables version detection, which will detect what versions are running on what port.                                                                                                                                            |
| -p-        | This flag scans for all TCP ports ranging from 0-65535                                                                                                                                                                          |
| -sV        | Attempts to determine the version of the service running on a port                                                                                                                                                              |
| --min-rate | This is used to specify the minimum number of packets Nmap should send per second; it speeds up the scan as the number goes higher                                                                                              |
| -p         | http, https                                                                                                                                                                                                                     |
| -P         | Port                                                                                                                                                                                                                            |

Changing the TCP connection options in nmap or using browser changes the type of network traffic in Wireshark. Differentiating all network scan traffic:

- **Browser**:
  The network traffic captured shows full TCP handshake (`SYN, SYN-ACK, ACK`) for each new TCP connection. This is because the browser is establishing a full connection to retrieve the requested web page.
- Nmap Scan with **`-sS`** (TCP SYN Scan):
  The network traffic sent is (`SYN, SYN-ACK`). If nmap receives SYN-ACK then it indicates the port is open. There is no complete handshake with an ACK packet instead Nmap immediately sends an `RST` packet to close the connection referred to as (a half-open scan). This makes the scan faster and less likely to be logged by the target system.
- Nmap Scan with **`-sT`** (TCP Connect Scan):
  The network traffic sent is a full TCP connection (`SYN, SYN-ACK, ACK`) with each target port. This type of scan is more likely to be logged by the target system because it establishes a full connection
