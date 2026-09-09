#!/bin/bash
# Obsidian Backup Script
# Backs up obsidian vault to Google Drive with encryption
# Keeps latest 30 backups

set -euo pipefail

# Configuration
OBSIDIAN_DIR="/home/yu/ghq/github.com/yuyagishita/obsidian"
REMOTE="gdrive-crypt:"
BACKUP_NAME="obsidian-$(date +%Y%m%d-%H%M%S)"
LOG_FILE="/home/yu/.local/share/obsidian-backup.log"
KEEP_BACKUPS=30

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

log "Starting Obsidian backup..."

# Perform backup
if rclone sync "$OBSIDIAN_DIR" "${REMOTE}${BACKUP_NAME}" \
    --exclude '.git/**' \
    --exclude '.obsidian/workspace*' \
    --exclude '.obsidian/cache' \
    --progress \
    --transfers 8 \
    --checkers 8 \
    2>&1 | tee -a "$LOG_FILE"; then
    log "Backup completed successfully: ${BACKUP_NAME}"
else
    log "ERROR: Backup failed!"
    exit 1
fi

# Clean up old backups (keep latest 30)
log "Cleaning up old backups (keeping latest ${KEEP_BACKUPS})..."

# List all backup directories, sort by name (which includes timestamp), and get old ones
OLD_BACKUPS=$(rclone lsf "${REMOTE}" --dirs-only 2>/dev/null | grep "^obsidian-" | sort -r | tail -n +$((KEEP_BACKUPS + 1)) || true)

if [ -n "$OLD_BACKUPS" ]; then
    while IFS= read -r backup; do
        log "Deleting old backup: ${backup}"
        rclone purge "${REMOTE}${backup}" 2>&1 | tee -a "$LOG_FILE"
    done <<< "$OLD_BACKUPS"
    log "Old backups cleaned up"
else
    log "No old backups to clean up"
fi

log "Backup process finished"
