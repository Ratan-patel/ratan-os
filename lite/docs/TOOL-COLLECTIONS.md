# Ratan OS Lite — Tool Collections

Ratan OS Lite keeps the minimum boot, network, terminal and XFCE components needed to operate a live security workstation. All other non-essential desktop applications, office suites, media tools, large developer stacks and server services are excluded to preserve a compact ISO.

## Collections

| Collection | Included tools | Intended authorized use |
|---|---|---|
| **Network & Discovery** | Nmap, arp-scan, traceroute | Map approved hosts, network assets and permitted paths. |
| **Web Assessment** | SQLMap, FFUF, Gobuster | Validate scoped web findings and discover approved paths/endpoints with agreed rate limits. |
| **Traffic Analysis** | tcpdump, TShark, MTR | Capture approved traffic, inspect protocols and investigate connectivity. |
| **TLS & Service Review** | SSLScan, WhatWeb, Nmap default checks | Review web technologies, TLS configuration and exposed services. |
| **Host Audit** | Lynis, Debsecan, UFW | Audit local configuration, review package exposure and manage a local firewall. |
| **Triage** | rkhunter, chkrootkit, lsof | Triage local anomalies and inspect files/processes using active sockets. |

## Safety boundary

Tool Collections are for explicitly authorized, rate-limited assessment and defensive work only. The image excludes DDoS/load generation, credential attacks, phishing, malware, stealth/persistence, data exfiltration and destructive payloads.

## Quick launcher

The live session will include the `ratan-collections` command and a desktop launcher. It prints the curated collections and starts no network activity by itself.
