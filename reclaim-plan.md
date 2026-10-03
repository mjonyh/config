# Space Reclaim Plan (~113 GB disk, 92 GB used)

## Safe targets (high reclaim, low risk)
1. ~/Library/Caches (~5.1 GB) — clear user app caches
2. /private/var/folders (~2.3 GB) — temp/user caches
3. /private/var/vm (~1.0 GB) — swap (free after restart or purge)
4. ~/Library/Logs (~150 MB) — old logs
5. ~/Downloads old files (~1.4 GB) — review/delete

## Medium risk (check first)
6. ~/Library/Application Support (~2.6 GB) — keep app-critical files
7. ~/git/config backups / old repos
8. npm/node_modules caches

## Commands to run
sudo purge  # free inactive memory/swap
rm -rf ~/Library/Caches/*
find ~/Library/Caches -type f -atime +30 -delete
rm -rf /private/var/folders/*/*/*/*  (user temp caches, careful)

## After cleanup
Restart to rebuild swap cleanly.
