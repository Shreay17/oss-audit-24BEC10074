#!/bin/bash
# =============================================================
# Script 1: System Identity Report
# Author: [Your Name] | Reg: [Your Registration Number]
# Course: Open Source Software | OSS NGMC Capstone
# Chosen Software: Git
# Description: Displays a welcome screen with system details
#              and identifies the open-source license of the OS.
# =============================================================

# --- Student Variables ---
STUDENT_NAME="[Your Name]"           # Replace with your actual name
REG_NUMBER="[Your Reg Number]"       # Replace with your registration number
SOFTWARE_CHOICE="Git"                # Chosen open-source software

# --- Gather System Information using command substitution $() ---
KERNEL=$(uname -r)                            # Linux kernel version
USER_NAME=$(whoami)                           # Current logged-in user
HOME_DIR=$(echo $HOME)                        # Home directory of current user
UPTIME=$(uptime -p)                           # Human-readable uptime
DATE_TIME=$(date '+%A, %d %B %Y | %H:%M:%S') # Formatted current date and time

# --- Detect Linux Distribution (reads from /etc/os-release if available) ---
if [ -f /etc/os-release ]; then
    # Source the file to load distribution variables
    . /etc/os-release
    DISTRO_NAME="$NAME"          # e.g., "Ubuntu", "Fedora", "Debian"
    DISTRO_VERSION="$VERSION_ID" # e.g., "22.04", "38"
else
    # Fallback if os-release is not available
    DISTRO_NAME="Unknown Distribution"
    DISTRO_VERSION="N/A"
fi

# --- Determine OS License based on distro name ---
# Most Linux distributions are licensed under GPL v2 at kernel level
case "$DISTRO_NAME" in
    *Ubuntu* | *Debian* | *Mint*)
        OS_LICENSE="GPL v2 (Kernel) + Various open-source licenses (userland)"
        ;;
    *Fedora* | *Red\ Hat* | *CentOS* | *Rocky*)
        OS_LICENSE="GPL v2 (Kernel) + GPL/LGPL (GNU coreutils)"
        ;;
    *Arch* | *Manjaro*)
        OS_LICENSE="GPL v2 (Kernel) + Mixed open-source licenses"
        ;;
    *)
        # Default fallback for any other Linux distribution
        OS_LICENSE="GPL v2 (Linux Kernel) — see kernel.org/legal.html"
        ;;
esac

# --- Display the System Identity Report ---
echo "=================================================================="
echo "       OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT                "
echo "=================================================================="
echo ""
echo "  Student  : $STUDENT_NAME"
echo "  Reg No.  : $REG_NUMBER"
echo "  Software : $SOFTWARE_CHOICE"
echo ""
echo "------------------------------------------------------------------"
echo "  SYSTEM INFORMATION"
echo "------------------------------------------------------------------"
echo "  Distribution : $DISTRO_NAME $DISTRO_VERSION"
echo "  Kernel       : $KERNEL"
echo "  User         : $USER_NAME"
echo "  Home Dir     : $HOME_DIR"
echo "  Uptime       : $UPTIME"
echo "  Date & Time  : $DATE_TIME"
echo ""
echo "------------------------------------------------------------------"
echo "  LICENSE"
echo "------------------------------------------------------------------"
echo "  OS License   : $OS_LICENSE"
echo ""
echo "  Note: Git (chosen software) is licensed under GPL v2."
echo "  GPL v2 ensures that all distributions of the software"
echo "  must also remain free and open source."
echo ""
echo "=================================================================="
echo "  'Free software is a matter of liberty, not price.' — Stallman"
echo "=================================================================="
