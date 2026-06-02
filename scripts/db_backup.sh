#!/bin/bash

# --- SETTINGS ---
export PGPASSWORD="PASSWORD"
DB_NAME="food_roulette_db"
USER_NAME="postgres"

# Username dynamically found on desktop
DESKTOP_PATH="/Users/$(whoami)/Desktop/postgre_otomasyon"
BACKUP_DIR="$DESKTOP_PATH/backups"
LOG_DIR="$DESKTOP_PATH/logs"

# Date and time format
TARIH=$(date +%Y-%m-%d_%H-%M)
BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_Backup_${TARIH}.backup"
LOG_FILE="$LOG_DIR/Yedek_Log_${TARIH}.txt"

echo "[$(date)] Yedekleme islemi baslatildi..." >> "$LOG_FILE"

# back up pg_dump
/Applications/pgAdmin\ 4.app/Contents/SharedSupport/pg_dump -U "$USER_NAME" -h localhost -F c -b -v -f "$BACKUP_FILE" "$DB_NAME" >> "$LOG_FILE" 2>&1

# Error Handling
if [ $? -eq 0 ]; then
    echo "[$(date)] BASARILI: Yedekleme sorunsuz tamamlandi." >> "$LOG_FILE"
else
    echo "[$(date)] HATA: Yedekleme sirasinda bir problem olustu!" >> "$LOG_FILE"
fi
