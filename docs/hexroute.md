I manage a few networks with Linux servers and Windows(r) clients, as a number
of the networks are interconnected through machines other than the default
route I have to manage static routes on the Windows client machines.  This
on the surface seems easy enough with dhcp, but a couple of the routes use
21 bit masks, and a couple use 26 bit masks.  This only seems to be possible
with the versions of dhcpd I am using by adding a code 249 option which
requires a hex encoded string for the route(s).

I created this tool to convert from a human readable form of the route to
the lines needed in dhcpd.conf.

For example to add the route
    192.168.20.64/26 through the gateway 192.168.10.62

The following lines need to be added to the dhcpd.conf file
    option new-static-routes code 249 = string;
    option new-static-routes 1a:c0:a8:14:40:c0:a8:0a:3e;

(I decided to use the name "new-static-routes" for the option as when trying
to figure out how to do this it was in an example lising I found on the web)

When dhcpd has reloaded it's config and a windows client that gets it's
ip settings from this server with the address 192.168.10.12, has the
command ipconfig /renew run there will now be the following entry it's
route listing. ( route print  or  netstat -r -n )
    192.168.20.64  255.255.255.192    192.168.10.62   192.168.10.12

Now we come to the reason for this BASH script, I got tired of doing the
conversion of the addresses from decimal to hex in my head, the line above
in decimal is pretty simple: 26:192:168:20:64:192:168:10:62; but my mind
isn't as agile as it used to be so I have trouble remembering that the bit
size comes before the target network, and while I can do the decimal to hex
conversion in my head it takes longer than it used to :(

So I created this script, simple pass it the target and gateway in the form
tt.tt.tt.tt/bb gg.gg.gg.gg and it returns the hex encoded string.

Add a -v before the target and it returns the entire line needed for
dhcpd.conf, add another -v and it also give the code 249 line.  You can
put as many routes on the line as required (I'm sure there's a limit in
dhcpd or windows, but I don't know what that would be)

examples:

$ hexroute 192.168.20.64/26 192.168.10.62
1a:c0:a8:14:40:c0:a8:0a:3e

$ hexroute -v 192.168.20.64/26 gw 192.168.10.62
option new-static-routes 1a:c0:a8:14:40:c0:a8:0a:3e;

$ hexroute -v -v 192.168.20.64/26 192.168.10.62
# New Option Type for Windows Client Static Routes
option new-static-routes code 249 = string;
option new-static-routes 1a:c0:a8:14:40:c0:a8:0a:3e;

$ hexroute -v 192.168.20.64/26 192.168.10.62 172.16.80.0/21 192.168.10.62
option new-static-routes 1a:c0:a8:14:40:c0:a8:0a:3e:15:ac:10:50:c0:a8:0a:3e;

The script is written for the bash shell, mileage under other shells may vary.
This script can be freely distributed, but please keep the header intact.

Karl McMurdo
hexrt(at)xrx.ca
http://www.xrx.ca/hexroute.html

Update: May 10, 2007
When I wrote the script I used 254 as the highest valid quad in an IP address,
which was based on my own personal preference to never use 255 in an address
as 255 is common in netmasks, but is incorrect.  Addresses using 255 are valid
so I have updated the script to allow 255 as part of an address.
Thanks to Victor Flausino for pointing this out to me.

Update: May 22, 2015
No change to the code, but an update to the email address in this file, the old one started getting bombarded with spam (no spam in the 10 years since this went onto the web, then over 300 in the last month.)

