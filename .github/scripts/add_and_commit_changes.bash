#!/usr/bin/env bash
set -e

# Honour workflow-provided snapshot time when present; otherwise capture now.
# This keeps the script independently runnable while preserving the workflow's
# "label = snapshot-request time" semantics when invoked from CI.
: "${BACKUP_TIMESTAMP:=$(TZ='Asia/Kolkata' date '+%d-%m-%Y %H-%M-%S IST')}"

DB_FILE=$(ls -t db_backups/*.sql | head -n 1)
git add "$DB_FILE"
git commit -m "Added DB Backup file $(basename "$DB_FILE") from ${SERVER_NAME} On ${BACKUP_TIMESTAMP}"
