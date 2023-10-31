# Install and Configure an SNMP v3 Manager and Agent Ubuntu 22.04

## The Manager

### Install

```shellscript
sudo apt-get update
sudo apt-get install snmp snmp-mibs-downloader
```

### Configuring
Open the /etc/snmp/snmp.conf file and comment out this line:
```
#mibs :
```

## The  Agent

### Install

```shellscript
sudo apt-get update
sudo apt-get install snmpd
```

### Configure

Open the /etc/snmp/snmpd.conf file and edit this:

#### Enable listening on localhost
```
agentaddress udp:127.0.0.1:161,udp6:[::1]:161
```

#### Disable v2 public community
```
# rocommunity  public default -V systemonly
# rocommunity6 public default -V systemonly
```

#### Create user named studentvirtual006 with hash password SHA-256 and AES encryption 
```
apt install libsnmp-dev
systemctl stop snmpd
net-snmp-config --create-snmpv3-user -ro -A P@ssw0rd -X P@ssw0rd -a SHA-256 -x AES studentvirtual006
systemctl restart snmpd
```

#### Get Incoming packets value

```shellscript
snmpwalk -v 3 -u studentvirtual006 -l authPriv -a SHA-256 -x AES -A P@ssw0rd -X P@ssw0rd localhost ifInUcastPkts
```

#### Setup Client Configuration File
Open the /etc/snmp/snmp.conf file and add this:

```
defSecurityName studentvirtual006  # The SNMPv3 username to authenticate as.
defSecurityLevel authPriv          # The security level to authenticate with.	
defAuthType SHA-256                # The authentication protocol to use.	
defPrivType AES                    # The privacy (encryption) protocol to use.
defAuthPassphrase P@ssw0rd         # The authentication passphrase for user.
defPrivPassphrase P@ssw0rd         # The authentication passphrase for user.
```

#### Get Incoming packets value after configuration file
```shellscript
snmpwalk localhost ifInUcastPkts
```


## Sources
[Source 1](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-an-snmp-daemon-and-client-on-ubuntu-14-04)

[Source 2](https://stackoverflow.com/questions/59239838/snmpwalk-unknown-user-name-snmp-v3) 





