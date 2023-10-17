---
title: Nmap Basics for Capture The Flag (CTF)
summary: Understand different options used in Nmap to scan targets
description: Understand different options used in Nmap to scan targets
slug: '/nmap-basic-for-capture-the-flag-ctf'
tags: []
draft: true
---

## Intro

`nmap` is Network Mapper used for network discovery and security auditing. Nmap can be used for enumeration to identify open ports and services. **Enumeration** in Cybersecurity is information gathering technique.

> Some of the scripts in this category are considered intrusive and should not be run against a target network without permission.

```bash
# Active host, network discovery
sudo nmap -sn 10.10.0.0/24

# Scan all ports, takes longer.
sudo nmap -p- <target-ip-addr>

# Enable version detection, name and description of identified services.
sudo nmap -sV <target-ip-addr>

# Performs a script scan using the default set of scripts
sudo nmap -sC <target-ip-addr>

# Aggressive scan.
nmap -A <target-ip-addr>

# Aggressive, OS detection, Time Template Aggressive, Scan for vulnerability.
nmap -A -O -T4 --script=vuln <target-ip-addr>
```

> RFC 9293 states that: "If the connection is CLOSED or doesn't exists, then a RST is sent in response."

### ping sweep

For black box penetration testing, "ping sweep" become very handy to map network structure with active IP address of hosts. Nmap provides `-sn` switch followed by IP range or CIDR notation to perform it.

```bash
nmap -sn 10.0.0.1-254
or
nmap -sn 10.10.0.0/24
```

### Nmap Options

| Options                     | Description                                                                                                                              |
| --------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| -sS                         | TCP SYN scan                                                                                                                             |
| -sT                         | TCP connect scan                                                                                                                         |
| -sU                         | UDP scans                                                                                                                                |
| -sN; -sF; -sX               | TCP NULL, FIN, and Xmas scans, used for firewall evasion. Microsoft Windows/Cisco devices respond with a RST to any malformed TCP packet |
| -sC                         | Performs a script scan using the default set of scripts. It is equivalent to --script=default.                                           |
| -sV                         | Enables version detection, which will detect what versions are running on what port.                                                     |
| -O; --osscan-guess; --fuzzy | Enable OS detection, guess near-match possibilities                                                                                      |
| -A                          | Aggressive Scan. Presently this enables OS detection (-O), version scanning (-sV), script scanning (-sC) and traceroute (--traceroute)   |
| -p-                         | This flag scans for all TCP ports ranging from 0-65535                                                                                   |
| -p <port-ranges>            | Scan specified ports                                                                                                                     |
| --min-rate <no. packet/sec> | This is used to specify the minimum number of packets Nmap should send per second; it speeds up the scan as the number goes higher       |

### Timing Templates

| T0       | T1     | T2     | T3     | T4         | T5     |
| -------- | ------ | ------ | ------ | ---------- | ------ |
| Paranoid | Sneaky | Polite | Normal | Aggressive | Insane |

## Understanding Network Traffic

Changing the TCP connection options in nmap or using browser changes the type of network traffic in Wireshark. Differentiating all network scan traffic:

- **Browser**:
  The network traffic captured shows full TCP handshake (`SYN, SYN-ACK, ACK`) for each new TCP connection. This is because the browser is establishing a full connection to retrieve the requested web page.
- Nmap Scan with **`-sS`** (TCP SYN Scan):
  The network traffic sent is (`SYN, SYN-ACK`). If nmap receives SYN-ACK then it indicates the port is open. There is no complete handshake with an ACK packet instead Nmap immediately sends an `RST` packet to close the connection referred to as (a half-open scan). This makes the scan faster and less likely to be logged by the target system.
- Nmap Scan with **`-sT`** (TCP Connect Scan):
  The network traffic sent is a full TCP connection (`SYN, SYN-ACK, ACK`) with each target port. This type of scan is more likely to be logged by the target system because it establishes a full connection

## Understanding NSE

The Nmap Scripting Engine (NSE) is a powerful reconnaissance tool used for vulnerabilities scan, automating exploits.

Some categories include (Reference: [TryHackMe](https://tryhackme.com/room/furthernmap)):

| category  | description                                                                                              |
| --------- | -------------------------------------------------------------------------------------------------------- |
| safe      | Won't affect the target                                                                                  |
| intrusive | **Not safe**: likely to affect the target                                                                |
| vuln      | Scan for vulnerabilities                                                                                 |
| exploit   | Attempt to exploit a vulnerability                                                                       |
| auth      | Attempt to bypass authentication for running services (e.g. Log into an FTP server anonymously)          |
| brute     | Attempt to bruteforce credentials for running services                                                   |
| discovery | Attempt to query running services for further information about the network (e.g. query an SNMP server). |

## References

- https://nmap.org/book/performance-timing-templates.html
- https://nmap.org/nsedoc/categories/vuln.html
- https://nmap.org/book/nse-usage.html
- https://mohomedarfath.medium.com/nmap-tryhackme-room-level-1-level-7-41ba9ff689ae
