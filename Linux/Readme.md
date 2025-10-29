# 🐧 Linux Directory Structure and Essential Commands

##  Top-Level Directory Structure (`/`)

```
/
├── bin/
├── boot/
├── dev/
├── etc/
├── home/
├── lib/
├── lib64/
├── media/
├── mnt/
├── opt/
├── proc/
├── root/
├── run/
├── sbin/
├── srv/
├── sys/
├── tmp/
├── usr/
└── var/
```

---

### `/bin` — Essential User Binaries
Contains basic user commands required for the system to boot and run.  
**Examples:**  
`ls`, `cp`, `mv`, `rm`, `cat`, `bash`, `echo`

---

### `/dev` — Device Files
Contains device files representing hardware or virtual devices.  
**Examples:**  
- `/dev/sda` → hard drive  
- `/dev/null` → null device  
- `/dev/tty` → terminal  

---

### `/etc` — System Configuration Files
Contains system-wide configuration files and shell scripts.  
**Examples:**  
`/etc/passwd`, `/etc/hosts`, `/etc/fstab`, `/etc/ssh/sshd_config`

---

### `/tmp` — Temporary Files
Used for temporary files created by users or applications.  
- Automatically cleared on reboot.  

---

### `/usr` — User Programs and Data
Contains user applications and utilities.

---

##  Input/Output Redirection

### `>` — Redirect Output to File
Redirects standard output to a file (overwrites existing file).  
```bash
echo "Hello" > file.txt
```

### `>>` — Append Output to File
Appends output instead of overwriting.  
```bash
echo "World" >> file.txt
```

### `2>` — Redirect Standard Error
Redirects standard error (stderr) to a file.  
```bash
ls /no/such/file 2> error.log
```

### `&>` — Redirect Both stdout and stderr
Redirects both standard output and error.  
```bash
command &> output.log
```

---

##  Standard Streams

| Stream | Name            | File Descriptor | Example Redirect |
|:-------|:----------------|:----------------|:-----------------|
| stdin  | Standard Input  | 0               | `< file.txt`     |
| stdout | Standard Output | 1               | `> file.txt`     |
| stderr | Standard Error  | 2               | `2> error.log`   |

---

##  `tar` Command — Archive and Compression Tool

| Option | Long Form | Description |
|:--------|:-----------|:-------------|
| `-c` | `--create` | Create a new archive |
| `-x` | `--extract` | Extract files from an archive |
| `-t` | `--list` | List contents of an archive |
| `-v` | `--verbose` | Show progress/details |
| `-f` | `--file` | Specify the archive filename |
| `-z` | `--gzip` | Compress/decompress with gzip (`.tar.gz`) |
| `-j` | `--bzip2` | Compress/decompress with bzip2 (`.tar.bz2`) |
| `-J` | `--xz` | Compress/decompress with xz (`.tar.xz`) |
| `-C` | `--directory` | Change directory before extracting or creating |
| `--delete` |  | Delete files from an archive (only uncompressed `.tar`) |

### Examples:
```bash
tar -cvf archive.tar /path/to/files     # Create archive
tar -xvf archive.tar                    # Extract archive
tar -czvf archive.tar.gz /path/to/files # Create compressed archive
```

---

##  Useful File Commands

| Command | Description |
|:---------|:-------------|
| `cd -` | Switch to previous directory |
| `ls -F` | Show file types |
| `ls -latr` | Long listing, all files, reverse order |
| `ls -r` | List in reverse order |
| `ls -t` | Sort by modification time |

---

##  File Permissions and Ownership

```bash
chmod u=rwx,g=rx,a= <filename>   # Change permissions
chgrp <groupname> <filename>     # Change group ownership
cp -r <source> <destination>     # Copy directories recursively
```

---

##  Find vs Locate

| Feature | `find` | `locate` |
|:---------|:--------|:----------|
| **Database Needed?** |  No — reads directly from disk |  Yes — uses `/var/lib/mlocate/mlocate.db` |
| **Speed** | Slower (scans in real-time) | Faster (uses prebuilt index) |
| **Accuracy** | Always up-to-date | May be outdated if DB not updated |
| **Manual Update** | Not needed | `sudo updatedb` |
| **Example** | `find /home -name file.txt` | `locate file.txt` |

---

## Find Command Examples

```bash
find /home/einfochips/Music -iname MYWEBAPP
find /home/einfochips/Videos -mtime +10
find /home/einfochips/Videos -mtime +10 -mtime -90
find /home/einfochips/Music -name "I*"      # Files starting with 'I'
find /home/einfochips/Music -size +100M     # Files larger than 100MB
find /home/einfochips -name "s*"
```

### Using `-exec` Option
Execute a command on each file found:
```bash
find [path] [conditions] -exec [command] {} \;
find /path/to/directory -name "*.tmp" -exec rm {} \;
find /path/to/directory -name "*.log" -exec gzip {} \;
```

---

##  Text and File Searching Commands

### `grep` — Search for Patterns
```bash
grep "word" filename
```

### `locate` — Find Files by Name
```bash
locate filename
```

### `which` — Locate a Command
```bash
which apache2
which nginx
```

### `sort` — Sort Lines of Text Files
```bash
sort filename
sort -r filename      # Reverse order
sort -u filename      # Remove duplicates
```

### `uniq` — Report or Omit Repeated Lines
```bash
uniq filename
```

### `wc` — Count Words, Lines, or Bytes
```bash
wc -w filename        # Count words
wc *.txt              # Count words or lines in all .txt files
```

### `du` — Check Disk Usage
```bash
du -h filename        # Display human-readable file size
```

---

##  Image Example
![alt text](image.png)