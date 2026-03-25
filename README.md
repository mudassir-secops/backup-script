# Automated Backup Script

A Bash script that automatically backs up a folder, logs every run,
and cleans up old backups. Scheduled with cron to run daily.

## What it does
- Creates a timestamped .tar.gz archive of your source folder
- Logs every run (success or failure) with date and time
- Deletes backups older than 7 days automatically
- Reports success or failure after every run

## How to configure
1. Clone this repo
2. Copy the example config:
   cp .env.example .env
3. Open .env and fill in your values:
   - SOURCE_DIR — folder you want to back up
   - BACKUP_DIR — where backups should be saved
   - RETENTION_DAYS — how many days to keep backups (default: 7)

## How to run manually
chmod +x backup.sh
bash backup.sh

## How to schedule with cron
Open cron editor:
   crontab -e

Add this line to run daily at 9 AM:
   0 9 * * * /bin/bash /home/YOUR_USERNAME/backup-script/backup.sh

## Project structure
backup-script/
├── backup.sh        # main script
├── .env.example     # config template (copy this to .env)
├── .gitignore       # ignores .env and archives
└── README.md        # this file

## Skills used
Bash scripting, variables, conditionals, tar, find,
cron scheduling, environment variables, trap, set -e
