#!/bin/bash
# =============================================================
# Script 2: FOSS Package Inspector
# Author: [Your Name] | Reg: [Your Registration Number]
# Course: Open Source Software | OSS NGMC Capstone
# Chosen Software: Git
# Description: Checks whether a FOSS package is installed,
#              retrieves version/license info, and prints a
#              philosophy note using a case statement.
# =============================================================

# --- Package to inspect (set to chosen software: git) ---
PACKAGE="git"   # Change this to test other packages (e.g., vlc, firefox, httpd)

echo "=================================================================="
echo "       FOSS PACKAGE INSPECTOR                                     "
echo "=================================================================="
echo ""
echo "  Inspecting package: $PACKAGE"
echo "------------------------------------------------------------------"

# --- Detect which package manager is available on this system ---
# Supports both RPM-based (Fedora/RHEL) and DEB-based (Ubuntu/Debian) systems

if command -v rpm &>/dev/null && rpm -q "$PACKAGE" &>/dev/null; then
    # --- RPM-based system: package IS installed ---
    echo "  Status  : INSTALLED (detected via RPM)"
    echo ""
    echo "  Package Details:"
    echo "  ----------------"
    # Extract key fields using grep with regex pattern matching
    rpm -qi "$PACKAGE" | grep -E "^(Version|License|Summary|URL)" | \
        while IFS= read -r line; do
            echo "    $line"
        done

elif command -v dpkg &>/dev/null && dpkg -l "$PACKAGE" 2>/dev/null | grep -q "^ii"; then
    # --- DEB-based system: package IS installed ---
    echo "  Status  : INSTALLED (detected via dpkg)"
    echo ""
    echo "  Package Details:"
    echo "  ----------------"
    # Use apt-cache to get detailed info (richer than dpkg -l)
    apt-cache show "$PACKAGE" 2>/dev/null | \
        grep -E "^(Version|Homepage|Description)" | head -5 | \
        while IFS= read -r line; do
            echo "    $line"
        done

elif command -v git &>/dev/null && [ "$PACKAGE" = "git" ]; then
    # --- Fallback: check via the binary directly (useful if installed from source) ---
    GIT_VERSION=$(git --version 2>/dev/null)
    echo "  Status  : INSTALLED (detected via binary)"
    echo "    Version : $GIT_VERSION"
    echo "    License : GPL v2"
    echo "    URL     : https://git-scm.com"

else
    # --- Package is NOT installed ---
    echo "  Status  : NOT INSTALLED"
    echo ""
    echo "  To install on Debian/Ubuntu : sudo apt install $PACKAGE"
    echo "  To install on Fedora/RHEL   : sudo dnf install $PACKAGE"
fi

echo ""
echo "------------------------------------------------------------------"
echo "  OPEN SOURCE PHILOSOPHY NOTE"
echo "------------------------------------------------------------------"

# --- Case statement: prints a philosophy note based on the package name ---
# This demonstrates the 'case' shell construct for pattern matching
case "$PACKAGE" in
    git)
        echo "  Git: Born out of necessity when Linus Torvalds rejected"
        echo "  all available version control tools. Git proves that open"
        echo "  source is not just about licenses — it is about freedom"
        echo "  to build the tool you need when none exists."
        ;;
    httpd | apache2)
        echo "  Apache: The web server that built the open internet."
        echo "  Powers ~30% of all websites globally — a testament to"
        echo "  what a community of volunteers can achieve together."
        ;;
    mysql | mariadb)
        echo "  MySQL/MariaDB: Open source at the heart of millions of apps."
        echo "  A dual-license model that raises important questions about"
        echo "  whether 'open source' and 'free software' always align."
        ;;
    vlc)
        echo "  VLC: Built by students in Paris to stream video over a"
        echo "  university network. Today it plays literally everything."
        echo "  A reminder that open-source contributors are often students."
        ;;
    firefox)
        echo "  Firefox: A nonprofit fighting for an open web. When IE"
        echo "  dominated, Mozilla proved that community can push back"
        echo "  against monopolies — one browser at a time."
        ;;
    python3 | python)
        echo "  Python: A language shaped entirely by community consensus."
        echo "  The PSF license and PEPs show how open governance can"
        echo "  produce one of the world's most-used languages."
        ;;
    libreoffice)
        echo "  LibreOffice: Born from a community fork of OpenOffice."
        echo "  A real-world example of the power of the GPL — when Oracle"
        echo "  bought Sun, the community forked and kept the freedom alive."
        ;;
    *)
        # Default case for any package not explicitly listed
        echo "  $PACKAGE: Every open-source tool you use was built by"
        echo "  someone who chose to share their work freely. That choice"
        echo "  is the foundation of the modern software world."
        ;;
esac

echo ""
echo "=================================================================="
