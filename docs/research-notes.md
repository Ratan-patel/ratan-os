# Research notes — Ratan OS

- Debian Live Manual documents `live-build` as the supported toolchain for custom Live system images, with package lists, configuration, testing, and hybrid ISO workflows.
- Kali's official documentation confirms that Kali Live images use `live-build`, package inclusion is controllable, and images can be tested in virtual machines. Its full default toolset is not appropriate for a strict 2 GB footprint.
- Project decision: create a Debian stable, XFCE-based **defensive security workstation**. Include assessment, analysis, reporting and hardening utilities; explicitly exclude DDoS/load-generation, credential attack, exploit automation, phishing, and stealth/persistence tools.

## Sources

1. Debian Live Manual: https://live-team.pages.debian.net/live-manual/html/live-manual/index.en.html
2. Kali Linux, Creating a Custom Kali ISO: https://www.kali.org/docs/development/live-build-a-custom-kali-iso/

## Expanded authorized-pentest toolset (2026-08-13)

- Debian Trixie ships `gobuster` 3.6.0-1 as a directory/file and DNS discovery tool (about 9.3 MB installed on amd64).
- Debian Trixie ships `sqlmap` 1.9.6-1 (about 10.9 MB installed). Ratan OS will label it as **authorization-only** and forbid data extraction, credential dumping, shell/file operations, or use outside the written scope.
- Debian Trixie ships `ffuf` as a fast web fuzzer; it will be used only for controlled endpoint/parameter discovery at a pre-agreed request rate.

3. Debian package gobuster (trixie): https://packages.debian.org/trixie/gobuster
4. Debian package sqlmap (trixie): https://packages.debian.org/trixie/sqlmap
5. Debian package ffuf (trixie): https://packages.debian.org/trixie/ffuf

Excluded even in the expanded edition: DDoS/load generators, password/credential attack tools, phishing/social engineering, persistence/stealth tooling, destructive payloads, and modules designed to obtain or exfiltrate data.
