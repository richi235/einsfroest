# Einsfroest

A Multipath Tunneling VPN Client and Server.   
Like OpenVPN, but with multiple links from Client to Server.

Note: This is a research prototype to evaluate different multipath packet scheduling algorithms.

## Properties 

 * The client uses several internet uplinks to connect the server, for increased throughput and connection stability
 * Runs in Userspace, like OpenVPN
 * Currently Linux only
 * the ```vpn_client_and_server.pl``` program acts as client and server in one, depending on the configuration file

## Installation (Package names are debian/ubuntu specific)

### On client
```bash
git clone https://github.com/richi235/Reinhard-VPN

# installing the required perl modules:
apt install libpoe-perl build-essential libnetpacket-perl liblog-fast-perl net-tools
cpan POE::XS::Loop::Poll

# copy the config
cp dynIpClient.example.cfg /etc/multivpn.cfg
```
Edit the config conforming to your network setup.

### On server 
```bash
git clone https://github.com/richi235/Reinhard-VPN

# installing the required perl modules:
apt install libpoe-perl build-essential libnetpacket-perl liblog-fast-perl
cpan POE::Wheel::UDP IO::Interface::Simple POE::XS::Loop::Poll

# copy the config
cp serverStaticIP.example.cfg /etc/multivpn.cfg
```
Edit the config conforming to your network setup.

