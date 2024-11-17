# SSLCI - SSL Certificate Inspector

SSLCI (**SSL Certificate Inspector**) is a lightweight and efficient tool built with Bash for discovering subdomains and apex domains from SSL certificates. It is especially useful for identifying cloud-based assets

## Features
- Accepts **single IPs** or **CIDR ranges** for scanning.
- Inspects SSL certificates to extract subdomains and apex domains.
- Outputs organized results in a user-friendly format.
- Saves results to a specified file for further analysis.

---

## Requirements

- **openssl**
- **nc**



---

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/SSLCI.git
   cd SSLCI
   ```

2. Make the script executable:
   ```bash
   chmod +x sslci.sh
   ```

3. download the required softwares listed above:
    ```bash
    apt install openssl
    apt install netcat-openbsd 
    ```



---

## Usage

### Command Syntax
```bash
./sslci.sh <IP_OR_RANGE> <OUTPUT_FILE>
```

### Arguments
- `<IP_OR_RANGE>`: Specify a single IP (e.g., `10.0.0.1`) or a CIDR range (e.g., `10.0.0.0/16`).
- `<OUTPUT_FILE>`: Provide the filename to save the results (e.g., `results.txt`).

---

## Example

### Scanning a Single IP
```bash
./sslci.sh 10.0.0.2 results.txt
```
**Output (results.txt):**
```
[inspecting ssl_cert from : 10.0.0.2:443 ][*.domain.com, supp.example.com]
```

### Scanning a CIDR Range
```bash
./sslci.sh 10.0.0.0/24 results.txt
```
**Output (results.txt):**
```
[inspecting ssl_cert from : 10.0.0.1:443][*.cloudhost.com, api.cloudhost.com]
[inspecting ssl_cert from : 10.0.0.2:443][*.example.com, admin.example.com]
...
```

---

## Key Output Details
- Each line in the output represents an inspected IP and its associated subdomains.
- Format:
  ```
  [<IP>:<PORT>][<SUBDOMAINS>]
  ```

---

## Use Cases
- **Cloud-Based Target Discovery**: Identify assets hosted on cloud infrastructure.
- **Penetration Testing**: Simplify the reconnaissance phase by uncovering subdomains.
- **CTF Challenges**: Accelerate web-based challenges requiring domain discovery.

---

