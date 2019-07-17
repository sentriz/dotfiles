### files
`$ crontab -e`

    # backup containers to raid array at 6am
    0 6 * * * /opt/containers/__backup
    # delete old/dangling images/volumes/etc at 6:10am
    10 6 * * * /usr/bin/docker system prune -f
