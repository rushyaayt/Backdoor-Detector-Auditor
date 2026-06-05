# Backdoor-Detector-Auditor
**Backdoor Detector & Auditor** is a defensive security and host auditing tool written in Bash. It is designed to assist system administrators, blue teamers, and security analysts in quickly scanning Linux environments for indicators of compromise (IoCs), unauthorized persistent backdoors, and suspicious system anomalies.

By automating low-level system audits, this lightweight utility helps identify unauthorized privilege escalations, rogue network connections, and hidden executable threats in common volatile directories.

---

## 🛠️ Key Features

- **Privilege Escalation Auditing:** Parses `/etc/passwd` to identify accounts mapped to `UID 0` (Root privileges), detecting backdoor accounts created for persistent administrative access.
- **Live Socket Tracking:** Scans the networking subsystem to filter established connections, revealing unauthorized reverse shells or active command-and-control (C2) communication channels.
- **Volatile Directory Auditing:** Inspects temporary directories (such as `/tmp`) to flag arbitrary executable binaries often dropped during initial exploitation or automated post-exploitation phases.
- **ANSI Colorized Diagnostics:** Utilizes structured logging formats (`[+] Secure`, `[!] Alert`, `[*] Auditing`) for immediate threat identification in the terminal.

---

## 📋 Prerequisites

To accurately audit system files and active network connections, the tool requires administrative access:
- **Operating System:** Any modern Linux distribution (Ubuntu, Debian, CentOS, Red Hat, Kali Linux).
- **Privileges:** **Root/Sudo permissions** are necessary to read sensitive system configuration paths and process sockets.

---

## 🚀 Installation & Setup

Execute the following commands sequentially within your Linux environment to clone and run the utility:

### 1. Clone the Repository
```bash
git clone [https://github.com/rushyaayt/Backdoor-Detector-Auditor.git](https://github.com/rushyaayt/Backdoor-Detector-Auditor.git)
cd Backdoor-Detector-Auditor
```
### 2. Configure Permissions
Grant executable privileges to the shell script:
```Bash
chmod +x backdoor_detector.sh
```
### 3. Execution (Requires Sudo)
Launch the host auditor using elevated privileges:
```Bash
sudo ./backdoor_detector.sh
```
## 📖 Operational Workflow
When executed, the script systematically initiates three primary defensive checks:
- 1. User Identity Verification: Extracts and prints all system accounts possessing a UID of 0. It triggers a critical warning if any user profile other than the native root user contains root privileges.
  2. Network Connection Audit: Leverages native socket utilities (ss / netstat) to display all outbound and inbound active connections currently in an ESTABLISHED state for administrative verification.
  3. Directory Integrity Check: Scans the /tmp hierarchy to list any file flagged with executable flags (+x), warning the administrator of potentially hidden scripts or tools.
## ⚠️ Legal Disclaimer
#### [!IMPORTANT]
### This security utility is distributed in good faith for Educational Use, System Auditing, and Defensive Hardening workflows. While it performs passive read-only checks, users must ensure they have explicit authorized consent before auditing enterprise infrastructures. The developer assumes no liability for administrative decisions, oversight, or system misconfigurations resulting from the use of this utility.
