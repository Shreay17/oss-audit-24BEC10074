#!/bin/bash
# =============================================================
# Script 3: Disk and Permission Auditor
# Author: [Your Name] | Reg: [Your Registration Number]
# Course: Open Source Software | OSS NGMC Capstone
# Chosen Software: Git
# Description: Loops through system directories to report
#              permissions, ownership, and disk usage.
#              Also checks Git's own config directory.
# =============================================================

# --- List of important system directories to audit ---
# These directories are core to how Linux organises its filesystem (FHS)
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/share" "/var/cache")

# --- Git-specific directories to check (chosen software) ---
GIT_DIRS=("/usr/share/git-core" "/etc/gitconfig" "$HOME/.git" "$HOME/.gitconfig")

echo "=================================================================="
echo "       DISK AND PERMISSION AUDITOR                                "
echo "=================================================================="
echo ""

# ==============================================
# SECTION 1: System Directory Audit (for loop)
# ==============================================
echo "  SECTION 1: SYSTEM DIRECTORY AUDIT"
echo "------------------------------------------------------------------"
printf "  %-20s %-25s %-10s\n" "Directory" "Permissions (type/owner/group)" "Size"
echo "  --------------------------------------------------------------------"

# --- for loop: iterate over each directory in the DIRS array ---
for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Extract permissions, owner, and group using ls -ld and awk
        # awk '{print $1, $3, $4}' extracts: perms, owner, group
        PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')

        # du -sh gives human-readable size; 2>/dev/null suppresses permission errors
        # cut -f1 extracts just the size field (before the tab)
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # Print formatted output (printf for aligned columns)
        printf "  %-20s %-25s %-10s\n" "$DIR" "$PERMS" "${SIZE:-N/A}"
    else
        # Directory does not exist on this system
        printf "  %-20s %s\n" "$DIR" "[ does not exist on this system ]"
    fi
done

echo ""

# ==============================================
# SECTION 2: Git Config Directory Check
# ==============================================
echo "------------------------------------------------------------------"
echo "  SECTION 2: GIT (CHOSEN SOFTWARE) CONFIG AUDIT"
echo "------------------------------------------------------------------"
echo "  Git stores its configuration in well-defined locations."
echo "  Checking known Git config paths..."
echo ""

# --- for loop: check each Git-specific path ---
for GPATH in "${GIT_DIRS[@]}"; do
    if [ -e "$GPATH" ]; then
        # -e checks for existence (file OR directory)
        # ls -ld works for both files and directories
        TYPE="file"
        [ -d "$GPATH" ] && TYPE="directory"   # Override if it's a directory

        PERMS=$(ls -ld "$GPATH" | awk '{print $1, $3, $4}')
        SIZE=$(du -sh "$GPATH" 2>/dev/null | cut -f1)

        echo "  Path     : $GPATH"
        echo "  Type     : $TYPE"
        echo "  Perms    : $PERMS"
        echo "  Size     : ${SIZE:-N/A}"
        echo ""
    else
        echo "  Path     : $GPATH"
        echo "  Status   : [ not found — Git may not be configured here ]"
        echo ""
    fi
done

# ==============================================
# SECTION 3: Filesystem Summary
# ==============================================
echo "------------------------------------------------------------------"
echo "  SECTION 3: FILESYSTEM DISK USAGE SUMMARY (df)"
echo "------------------------------------------------------------------"
# df -h shows all mounted filesystems in human-readable format
# grep -v "tmpfs" filters out temporary filesystems for cleaner output
df -h | grep -v "tmpfs" | grep -v "udev" | \
    awk 'NR==1 || /^\// {printf "  %-30s %-8s %-8s %-8s %s\n", $6, $2, $3, $4, $5}'

echo ""
echo "=================================================================="
echo "  Audit complete. Review permissions carefully — open-source"
echo "  systems rely on proper file permissions for security."
echo "=================================================================="
