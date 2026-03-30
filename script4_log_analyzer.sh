#!/bin/bash
# =============================================================
# Script 4: Log File Analyzer
# Author: [Your Name] | Reg: [Your Registration Number]
# Course: Open Source Software | OSS NGMC Capstone
# Chosen Software: Git
# Description: Reads a log file line by line, counts occurrences
#              of a keyword, and prints a summary with the last
#              5 matching lines. Includes retry logic if file
#              is empty.
# Usage: ./script4_log_analyzer.sh /var/log/syslog [keyword]
#        ./script4_log_analyzer.sh /var/log/messages error
# =============================================================

# --- Command-line arguments ---
# $1 is the first argument (log file path)
# $2 is the optional second argument (keyword); defaults to "error" if not provided
LOGFILE=$1
KEYWORD=${2:-"error"}   # Default keyword is 'error' if none given

# --- Counter variable (starts at zero) ---
COUNT=0

# --- Temporary file to store matching lines ---
MATCH_FILE="/tmp/log_matches_$$.tmp"   # $$ is the current process ID (ensures uniqueness)

# ==============================================
# INPUT VALIDATION
# ==============================================

# Check if a log file argument was actually provided
if [ -z "$LOGFILE" ]; then
    echo "=================================================================="
    echo "  ERROR: No log file specified."
    echo "  Usage: $0 /path/to/logfile [keyword]"
    echo "  Example: $0 /var/log/syslog error"
    echo "=================================================================="
    exit 1   # Exit with non-zero status to signal failure
fi

# Check if the specified file exists and is a regular file
if [ ! -f "$LOGFILE" ]; then
    echo "=================================================================="
    echo "  ERROR: File '$LOGFILE' not found."
    echo "  Please check the path and try again."
    echo "=================================================================="
    exit 1
fi

# ==============================================
# RETRY LOGIC: Handle empty log files
# do-while style using a while loop with break
# ==============================================
MAX_RETRIES=3     # Maximum number of retry attempts
ATTEMPT=0         # Current attempt counter

while true; do
    ATTEMPT=$((ATTEMPT + 1))   # Increment attempt counter

    # Check if the file has content (not empty)
    if [ -s "$LOGFILE" ]; then
        break   # File has content — exit the retry loop
    fi

    # File is empty — handle retry
    if [ $ATTEMPT -ge $MAX_RETRIES ]; then
        echo "  WARNING: '$LOGFILE' is empty after $MAX_RETRIES checks."
        echo "  No log entries to analyse. Exiting."
        exit 0
    fi

    # Inform user and wait before retrying
    echo "  File appears empty (attempt $ATTEMPT/$MAX_RETRIES). Retrying in 2s..."
    sleep 2   # Wait 2 seconds before next attempt (do-while retry behaviour)
done

# ==============================================
# MAIN ANALYSIS: while read loop
# ==============================================
echo "=================================================================="
echo "       LOG FILE ANALYZER                                          "
echo "=================================================================="
echo ""
echo "  Log File : $LOGFILE"
echo "  Keyword  : '$KEYWORD' (case-insensitive)"
echo "------------------------------------------------------------------"

# Clear the temporary match file before starting
> "$MATCH_FILE"

# --- while read loop: process file line by line ---
# IFS= prevents leading/trailing whitespace from being stripped
# -r flag prevents backslash interpretation
while IFS= read -r LINE; do
    # --- if-then: check if the current line contains the keyword ---
    # grep -iq: -i = case-insensitive, -q = quiet (no output, just exit code)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))          # Increment match counter
        echo "$LINE" >> "$MATCH_FILE" # Save matching line to temp file
    fi
done < "$LOGFILE"   # Redirect file content into the while loop

# ==============================================
# RESULTS SUMMARY
# ==============================================
echo ""
echo "  RESULTS:"
echo "  --------"
echo "  Total lines in file    : $(wc -l < "$LOGFILE")"
echo "  Matching lines found   : $COUNT"
echo ""

# --- Conditional output based on count ---
if [ $COUNT -eq 0 ]; then
    echo "  No lines containing '$KEYWORD' were found."
else
    echo "------------------------------------------------------------------"
    echo "  LAST 5 MATCHING LINES:"
    echo "------------------------------------------------------------------"
    # tail -5 retrieves the last 5 lines of the match file
    # This is more efficient than re-scanning the original file
    tail -5 "$MATCH_FILE" | while IFS= read -r MATCH_LINE; do
        # Truncate long lines to 80 chars for readability
        echo "  ${MATCH_LINE:0:80}"
    done
fi

echo ""
echo "=================================================================="

# --- Cleanup: remove temporary file when done ---
# Preventing temp file accumulation is good practice
rm -f "$MATCH_FILE"

exit 0   # Explicit successful exit
