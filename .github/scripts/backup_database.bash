#!/usr/bin/env bash
set -e

mkdir -p db_backups
BACKUP_FILE="db_backups/${SERVER_NAME}-${DB_USER}-${DB_NAME}.sql"
mysqldump --column-statistics=0 -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" > "$BACKUP_FILE"
sed -i 's/),(/),\n(/g' "$BACKUP_FILE"
