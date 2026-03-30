# About This Project

Within this repository are five shell scripts developed and submitted for the OSS NGMC course, the capstone project entitled “Open Source Audit.” The selected open-source software was Git, a distributed version control system originally developed in 2005 by Linus Torvalds and distributed under the terms of the GNU General Public License v2.

All of the scripts illustrate a practical example of proficiency in both Linux and shell scripting, and are all conceptually related back to the philosophy of open-source software development.

---

# Scripts Overview

| Script | File | Description |
|--------|------|-------------|
| 1 | `script1_system_identity.sh` | Displays a system welcome screen with kernel version, user, uptime, distro, and OS license info |
| 2 | `script2_package_inspector.sh` | Checks if Git is installed, retrieves version or license details, and prints a philosophy note using a 'case' statement |
| 3 | `script3_disk_permission_auditor.sh` | Audits system directories for permissions, ownership, and disk usage; includes a Git-specific config directory check |
| 4 | `script4_log_analyzer.sh` | Reads a log file line by line, counts keyword occurrences, and prints the last 5 matching lines with retry logic |
| 5 | `script5_manifesto_generator.sh` | Interactively generates a personalised open-source philosophy statement and saves it to a `.txt` file |

---

# Using the Scripts on Linux
# Necessary Components
Use a Linux operating system like Ubuntu, Fedora, Debian etc
The bash command line program 
The git command line utility must be installed or "dnf" to install for fedora/redhat.

# Step by Step Instructions

**1. Clone the repository**
```bash
git clone https://github.com/[yourusername]/oss-audit-[rollnumber].git
cd oss-audit-24BEC10074
```

**2. Make all scripts executable**
```bash
chmod +x script1_system_identity.sh
chmod +x script2_package_inspector.sh
chmod +x script3_disk_permission_auditor.sh
chmod +x script4_log_analyzer.sh
chmod +x script5_manifesto_generator.sh
```

**3. Run Script 1 — System Identity Report**
```bash
./script1_system_identity.sh
```
No arguments needed. Displays system info and license.

**4. Run Script 2 — FOSS Package Inspector**
```bash
./script2_package_inspector.sh
```
Checks whether git is installed or not and prints a philosophy note. To test another package and edit the `PACKAGE` variable inside the script


**5. Run Script 3 — Disk and Permission Auditor**
```bash
./script3_disk_permission_auditor.sh
```
audits `/etc`, `/var/log`, `/home`, `/usr/bin`, `/tmp` and git config paths.

**6. Run Script 4 — Log File Analyzer**
```bash
# Use: ./script4_log_analyzer.sh <logfile> [keyword]

./script4_log_analyzer.sh /var/log/syslog error

./script4_log_analyzer.sh /var/log/messages warning


./script4_log_analyzer.sh /var/log/auth.log failed
```
log file path has valid to be the first argument. Keyword defaults to `error`.

**7. Run Script 5 — Manifesto Generator**
```bash
./script5_manifesto_generator.sh
```
Interactive — the script will ask you three questions. Saves output to `manifesto_<username>.txt` in the current directory.

---

## Shell Concepts Used

| Concept | Scripts |
|---------|---------|
| Variables and commands substitution `$()` | 1, 2, 3, 4, 5 |
| `if then else` and `[]` conditions | 1, 2, 3, 4, 5 |
| `case` statement | 1, 2 |
| `for` loop with arrays | 3 |
| `while read` loop | 4 |
| Counter variables and arithmetic `$(())` | 4 |
| Command-line arguments `$1`, `$2` | 4 |
| `read` for interactive input | 5 |
| File redirection `>` and `>>` | 5 |
| `date` command and formatting | 1, 5 |
| Pipe with `grep`, `awk`, `cut` | 2, 3, 4 |
| Alias concept | 5 |

---

## Dependencies

| Dependency | Required By | Install Command |
|------------|-------------|-----------------|
| `bash` | All scripts | Pre-installed on all Linux systems |
| `git` | Scripts 2, 3 | `sudo apt install git` |
| `rpm` or `dpkg` | Script 2 | Pre-installed on RPM/DEB systems |
| `df`, `du`, `ls` | Script 3 | Pre-installed|
| `grep`, `awk`, `cut` | Scripts 2, 3, 4 | Pre-installed |
| `uname`, `uptime`, `whoami` | Script 1 | Pre-installed |

---
 
## Project Report

The full project report in pdf format is submitted separately on the VITyarthi portal as required.

---

## License
The chosen software git is licensed under **GPL v2**.
