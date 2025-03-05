# AutoNmapScan
As part of my job as a pentester, I created a tool to automate the scan of my company's public IP addresses. This tool scans a list of IP addresses along with their neighboring IPs (the previous and next IPs in the sequence) for vulnerabilities and open ports using Nmap. The result is save with date & time of the scan.

# Installation

## 1. To get started, clone this repository, open your terminal and run the following command:

```bash
git clone https://github.com/Jeremiznoo/AutoNmapScan/
```

## 2. Navigate into the cloned directory

```bash
cd AutoNmapScan/
```

## 3. Make the script executable and execute the script

```bash
chmod +x autonmapscan.sh
./autonmapscan.sh
```
# Usage

You will be prompted to provide a file with IP :

```
Please specify the path to your IP list file (e.g., /path/to/ip_list.txt):
/home/user/ip_list.txt
```
This file must be like this : 

```
192.168.1.1
127.0.0.1
10.0.0.1
```
The script will output the results with filenames based on the current date and time, for example:

```
scan_2025-03-05_14-30-00.nmap
scan_2025-03-05_14-30-00.xml
scan_2025-03-05_14-30-00.gnmap
```
