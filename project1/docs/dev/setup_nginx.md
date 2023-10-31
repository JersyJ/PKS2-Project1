# Setup NGINX Ubuntu 22.04

## Install Nginx

```shellscript
sudo apt update
sudo apt install nginx
```

## Firewall

### Get Ufw list of app configurations
```shellscript
sudo ufw app list
```

### Allow chosen configuration
```shellscript
sudo ufw allow 'Nginx Full'
```

## Start/Stop/Restart
```shellscript
sudo systemctl start/stop/restart nginx
```

## Default server block path
```
/var/www/html
```