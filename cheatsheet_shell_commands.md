# Commands That Will Change The Way You Use Linux Forever

1. `cd -` : back to the last directory we've been to.
2. `ctrl+l`: clear screen
3. `reset`: clear on steroids - resets terminal session
4. `pushd /var` + few other `cd` commands + `popd`: commands that allow you to work with directory stack and change the current working directory
5. `vim /etc/ssh/sshd_config` + ctrl+fz (if nano -> ctrl+tz) : isn't closing, but minimizing the window to the back ground
   1. `fg` : bring back the window to the front.
6. `apt update`: would fail - cuz we forgot sudo
   1. `sudo !!` : would run the last command as sudo
7. `ctrl+r` : "(reverse-i-search)_apt_: sudo _apt_ update" -> type what you want to find, press `ctrl+r` until you find, then `Enter`
8. run command that already been run - `history`, choose a number of command and run it `!102` -> the 102 command from the history would run again
9. HISTTIMEFORMAT="%Y-%m-%d %T " : `history` would show the history commands by the format.
   another way to add the format, is add it to the `~/.bashrc` file with `vim` or `nano` commands.
10. cmatrix -> let you look cool + ctrl c to escape
11. adjust font up `ctrl+shift +` or down `ctrl -`, `reset` command would reset the font size
12. line navigation:
    1. `ctrl a` - go to the start of the line
    2. `ctrl e` - got to the end of the line
    3. `ctrl u` - delete whole line
13. chaining commands -> `ls -l; echo "hello"` or -> `ls -l && echo "hello"` && - would stop when meets an error `;` - would pop up an error and keep on running the second/next command
14. `tail` / `head` commands to see top or bottom of a file.
    1. `tail -f /var/log/syslog` : monitor in real-life time
15. truncate (be cautious while using this one - its risky) : it allows to change the size of a very large files (like log files) or example `truncate -s <size_of_file> <name_of_file>` == truncate -s 0 hello.txt to empty the hello.txt file
16. `mount | column -t` : make sure all the output shows in columns any verbose and messy command output would look better using `| column -t`

## Kill process on port

sudo lsof -i -P -n | grep <port number> # List who's using the port
kill -9 <process id> (macOS) or sudo kill <process id> (Linux)

## Python related

```shell
#!/bin/bash

# find Django path in env
python -c "import django; print(django.__path__)"
```

## PostgreSQL related

```shell
# For a interactive login shell as `postgres` user
$ sudo -u postgres -i
# is !! preferable to...
sudo su - postgres


postgres@ws-lv-cp3528:~$ psql
psql (15.1 (Ubuntu 15.1-1.pgdg22.04+1), server 14.6 (Ubuntu 14.6-1.pgdg22.04+1))
Type "help" for help.

postgres=# \du
postgres=# CREATE DATABASE db_foo_name;


# command execution
sudo -u postgres psql -c "SELECT 1"

# Use systemctl/service/other commands to manage postgresql service:
# Initialize the server by running the command:
sudo service postgresql initdb

# 1. START
# all
systemctl start postgresql
sudo service postgresql start

# start specific server
systemctl start postgresql@14-main
sudo service postgresql start ##
sudo service postgresql-14.2 start

## 2. STOP
systemctl stop postgresql
service postgresql stop

# 3. STATUS
systemctl status postgresql@14-main
service postgresql status
pgrep -u postgres -fa -- -D

# show information about all PostgreSQL clusters
pg_lsclusters

# 4. DISABLE (not auto-start any more)
systemctl disable postgresql

# 5. ENABLE (auto-start)
systemctl enable postgresql
systemctl enable postgresql@14-main

# Find PostgreSQL location
sudo find /usr -wholename '*/bin/postgres'

# Find your port
# example: sudo sed -n 4p <$PGDATA>/postmaster.pid
sudo sed -n 4p /var/lib/postgresql/13/main/postmaster.pid


# Control cluster startup
cat /etc/postgresql/14/main/start.conf

```

## grep

snap info microk8s | grep installed

## Docker

````shell
[sudo] systemctl (start|stop|restart) docker

sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Rootless Docker mode
## deamon

```shell
# Use systemctl --user to manage the lifecycle of the daemon:
systemctl --user start docker

# To launch the daemon on system startup, enable the systemd service and lingering:
systemctl --user enable docker
sudo loginctl enable-linger $(whoami)

## client
```shell
# To specify the socket path using $DOCKER_HOST:
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
docker run -d -p 8080:80 nginx

# To specify the CLI context using docker context:
docker context use rootless
docker run -d -p 8080:80 nginx

# Stop and remove containers
docker-compose down  # Stop container on current dir if there is a docker-compose.yml
docker rm -fv $(docker ps -aq)  # Remove all containers
````

## Docker Compose

```yaml
volumes:
  # Just specify a path and let the Engine create a volume
  - /var/lib/mysql

  # Specify an absolute path mapping
  - /opt/data:/var/lib/mysql

  # Path on the host, relative to the Compose file
  - ./cache:/tmp/cache

  # User-relative path
  - ~/configs:/etc/configs/:ro

  # Named volume
  - datavolume:/var/lib/mysql
```

## Permissions

rwx rwx rwx = 111 111 111
rw- rw- rw- = 110 110 110
rwx --- --- = 111 000 000

and so on...

rwx = 111 in binary = 7
rw- = 110 in binary = 6
r-x = 101 in binary = 5
r-- = 100 in binary = 4

    d is a directory

    rwx the user has read, write, and execute permissions

    rw- the group has read and write permissions

    r– all others have read only permissions

-rw-r--r-- 12 ivan.prytula domain users 12.0K Apr 28 10:10 file_name
|[-][-][-]- [------] [---]
| | | | | | |
| | | | | | +-----------> 7. Group
| | | | | +-----------------------> 6. Owner
| | | | +------------------------------> 5. Alternate Access Method
| | | +--------------------------------> 4. Others Permissions
| | +-----------------------------------> 3. Group Permissions
| +--------------------------------------> 2. Owner Permissions
+----------------------------------------> 1. File Type

## Ruby

```shell
/usr/bin/zsh --login
rvm use 3.1.2
```

## Current system’s timezone

```shell
timedatectl
```

### Disk usage

```shell
du -h --summarize --total
du -h --all --exclude="venv" --exclude=".idea" --exclude="htmlcov" --exclude=".git" --exclude=".pytest_cache" --exclude="tmp"
du -h -a/-s * | sort -h
```

## Battery life

```shell
cd /sys/class/power_supply/BAT0/
cat uevent
```

### hands-on shell commands

```shell
cd scripts/local_docker && docker compose up -d redis && cd -
cd scripts/local_docker && docker compose stop && cd -
pg_lsclusters

docker compose exec db psql
docker compose exec app python3


./manage.py migrate --check
git reset --soft HEAD~1

git log --follow -p -- pyproject.toml
git rebase -i HEAD~4

p sha1
p sha2
s sha3
s sha4
# will squash 2, 3 and 4 commits into one >>> we need do `push --force`
```

source "$( poetry env list --full-path | grep Activated | cut -d' ' -f1 )/bin/activate"