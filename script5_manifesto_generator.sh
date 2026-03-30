#!/bin/bash
# =============================================================
# Script 5: Open Source Manifesto Generator
# Author: [Your Name] | Reg: [Your Registration Number]
# Course: Open Source Software | OSS NGMC Capstone
# Chosen Software: Git
# Description: Interactively gathers three answers from the user,
#              composes a personalised open-source philosophy
#              paragraph, and saves it to a .txt file.
# Concepts: read, string concatenation, file redirection (>),
#           date command, alias demonstration via comment.
# =============================================================

# --- Alias concept demonstration ---
# In a real terminal session, you could run: alias today='date +%d\ %B\ %Y'
# and then call 'today' as a shortcut. In scripts, aliases are disabled by
# default, so we use a function to achieve the same effect.

# Function: today — acts like an alias for a formatted date string
today() {
    date '+%d %B %Y'   # Returns date like: 15 March 2025
}

# --- Welcome Banner ---
echo "=================================================================="
echo "       OPEN SOURCE MANIFESTO GENERATOR                           "
echo "=================================================================="
echo ""
echo "  Answer three questions to generate your personal open-source"
echo "  philosophy statement. Your manifesto will be saved to a file."
echo ""
echo "------------------------------------------------------------------"

# ==============================================
# USER INPUT: read command for interactive input
# ==============================================

# read -p: displays a prompt and waits for user input
# The answer is stored in the named variable

echo ""
read -p "  1. Name one open-source tool you use every day: " TOOL

# Validate: ensure the user did not leave the answer blank
while [ -z "$TOOL" ]; do
    echo "  Please enter a tool name (e.g., git, firefox, vim)."
    read -p "  1. Name one open-source tool you use every day: " TOOL
done

echo ""
read -p "  2. In one word, what does 'freedom' mean to you? " FREEDOM

# Validate: single word check — remove spaces and compare
FREEDOM_CLEAN=$(echo "$FREEDOM" | tr -d ' ')
while [ -z "$FREEDOM_CLEAN" ]; do
    echo "  Please enter a single word (e.g., choice, access, power)."
    read -p "  2. In one word, what does 'freedom' mean to you? " FREEDOM
    FREEDOM_CLEAN=$(echo "$FREEDOM" | tr -d ' ')
done
FREEDOM="$FREEDOM_CLEAN"  # Use the cleaned (no-space) version

echo ""
read -p "  3. Name one thing you would build and share freely: " BUILD

while [ -z "$BUILD" ]; do
    echo "  Please enter something you would build (e.g., a Linux tutorial, an app)."
    read -p "  3. Name one thing you would build and share freely: " BUILD
done

echo ""
echo "------------------------------------------------------------------"
echo "  Generating your manifesto..."
echo "------------------------------------------------------------------"

# ==============================================
# COMPOSE THE MANIFESTO (string concatenation)
# ==============================================

# Get current date using the today() function defined above
DATE=$(today)

# Output filename: personalised using the current username
OUTPUT="manifesto_$(whoami).txt"

# --- Build the manifesto paragraph using string concatenation ---
# Each line is appended to build the full paragraph
LINE1="My Open Source Manifesto — $(whoami) | $DATE"
LINE2="=================================================="
LINE3=""
LINE4="Every day, I rely on $TOOL — a piece of software that someone,"
LINE5="somewhere, chose to build in the open and give away freely. That"
LINE6="act of generosity is not naive; it is the foundation on which the"
LINE7="modern world runs. To me, freedom means $FREEDOM — and in software,"
LINE8="that freedom means the right to read, modify, share, and improve"
LINE9="the tools we all depend on."
LINE10=""
LINE11="I believe that knowledge should not be locked behind proprietary"
LINE12="walls. If I could build one thing and share it freely with the world,"
LINE13="it would be $BUILD — because the value of an idea grows when others"
LINE14="can build upon it. This is what open source taught me: that standing"
LINE15="on the shoulders of giants is not theft. It is how civilisation works."
LINE16=""
LINE17="I commit to using open-source tools responsibly, contributing back"
LINE18="where I can, and understanding the licenses that protect the freedoms"
LINE19="I benefit from every single day."
LINE20=""
LINE21="Signed: $(whoami)"
LINE22="Date: $DATE"
LINE23="=================================================="

# --- Write to file using > (overwrites) and >> (appends) ---
# First line uses > to create/overwrite the file
echo "$LINE1"  > "$OUTPUT"
echo "$LINE2" >> "$OUTPUT"
echo "$LINE3" >> "$OUTPUT"
echo "$LINE4" >> "$OUTPUT"
echo "$LINE5" >> "$OUTPUT"
echo "$LINE6" >> "$OUTPUT"
echo "$LINE7" >> "$OUTPUT"
echo "$LINE8" >> "$OUTPUT"
echo "$LINE9" >> "$OUTPUT"
echo "$LINE10" >> "$OUTPUT"
echo "$LINE11" >> "$OUTPUT"
echo "$LINE12" >> "$OUTPUT"
echo "$LINE13" >> "$OUTPUT"
echo "$LINE14" >> "$OUTPUT"
echo "$LINE15" >> "$OUTPUT"
echo "$LINE16" >> "$OUTPUT"
echo "$LINE17" >> "$OUTPUT"
echo "$LINE18" >> "$OUTPUT"
echo "$LINE19" >> "$OUTPUT"
echo "$LINE20" >> "$OUTPUT"
echo "$LINE21" >> "$OUTPUT"
echo "$LINE22" >> "$OUTPUT"
echo "$LINE23" >> "$OUTPUT"

# ==============================================
# DISPLAY THE RESULT
# ==============================================
echo ""
echo "  Manifesto saved to: $OUTPUT"
echo ""
echo "=================================================================="
echo ""

# cat: display the saved file contents to the screen
cat "$OUTPUT"

echo ""
echo "=================================================================="
echo "  'The cathedral is built by many hands, but it belongs to all.'"
echo "=================================================================="
