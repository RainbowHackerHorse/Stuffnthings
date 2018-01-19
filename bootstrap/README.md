# freebsd-puppet4deploy.sh
## A puppet4 deployment script for FreeBSD

Deploy Puppet 4 quickly on FreeBSD

### Usage:
As root:
```
fetch "https://githubusercontent.com/RainbowHackerHorse/Stuffnthings/master/bootstrap/freebsd-puppet4deploy.sh"
chmod +x freebsd-puppet4deploy.sh
./freebsd-puppet4deploy.sh --local MY.NODE.NAME --puppetserver MY.PUPPET.HOST
```
using `-a` will also cause the script to install `mosh` and `tmux`. This is a default for me but I recognized not everyone wants them by default.