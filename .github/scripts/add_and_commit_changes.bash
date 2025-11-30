#!/usr/bin/env bash
set -e

DB_FILE=$(ls -t db_backups/*.sql | head -n 1)
git add "$DB_FILE"
DB_TIMESTAMP=$(TZ='Asia/Kolkata' date -r "$DB_FILE" "+%d-%m-%Y %H-%M-%S IST")
git commit -m "Added DB Backup file $(basename "$DB_FILE") from ${SERVER_NAME} On ${DB_TIMESTAMP}"
