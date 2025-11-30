#!/usr/bin/env bash
set -e

DB_FILE=$(ls -t db_backups/*.sql | head -n 1)

DIFF_OUTPUT=$(git diff -- "$DB_FILE")

# Process the diff output to remove irrelevant lines
CLEANED_DIFF=$(echo "$DIFF_OUTPUT" | sed -E '
    /^diff --/d;                          # Remove diff metadata lines
    /^index /d;                           # Remove index lines
    /^--- a/d;                            # Remove old file path
    /^\+\+\+ b/d;                         # Remove new file path
    /^@@ /d;                              # Remove hunk headers
    /^[[:space:]]*\/\*!/d;                # Remove comments starting with /*! 
    /^[+-]-- Dump completed on/d;         # Remove added or removed "Dump completed on" lines
    /^[[:space:]]*$/d                     # Remove blank or whitespace-only lines
')

# Check if the cleaned diff output is empty or contains meaningful changes
if [ -z "$CLEANED_DIFF" ]; then
    echo "No meaningful changes detected."
    echo "changed=false" >> "$GITHUB_ENV"
else
    echo "There are meaningful database changes."
    echo "changed=true" >> "$GITHUB_ENV"
fi
