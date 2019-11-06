<h2>Harden Firewall Script Documentation</h2>
<b>This program allows you to:</b>

1) Show IP Tables                                
2) Disable Pings - Prevent Pings                 
3) Drop invalid packets                          
4) Drop TCP packets that are new and are not SYN 
5) Drop SYN packets with suspicious MSS value    
6) Block packets with bogus TCP flags            
7) Block spoofed packets                         
8) Drop ICMP (rare protocol)                     
9) Drop fragments in all chains                  
10) Limit connections per source IP              
11) Limit RST packets                            
12) Limit new TCP connections/second/source IP   
13) Use SYNPROXY on all ports                    
14) SSH brute-force protection                   
15) Protection against port scanning             
16) Add All Above Rules                          
17) Remove All Rules                             
18) Save All Rules                               
19) Restore saved rules                          
20) Set all rules to reload upon reboot.         
21) Disable reboot restore rules                 
22) Allow/Block SSH Connections.                 
23) Allow/Block Basic Webserver configurations.  
24) Allow/Block mySQL configurations.            
25) Allow/Block Telnet configurations.          
26) Allow/Block Email configurations.           
27) Allow/Block IP Address.                     
28) Allow/Block Ports                           
29) Allow/Block MAC Address Access.              

Any Linux server that is accessible by anyone on a network should have some form of firewall protecting is from outside attackers. This tool has been created to make it easy to modify your firewall rules so your Linux machine can stay as protected as it needs to be. 
To run this program, you must have sudo privileges. 

```sudo bash hardenFirewall.sh```
 
Upon starting the program you are asked if you want to enable to disable existing rules. If this is your first time running the program, press “e” to enable rules. 
Note: This step is necessary for every option later on. If you plan on blocking an IP or MAC address, press E to enable a rule. If you want to unblock an IP address currently being blocked, press D.
 
As you can see above, this program offers many options, most of which are preconfigured and ready to go. To break this down quickly, know that options 2-15 and 22-26 are set values ready for your needs. 

Values 17, 18, 19, and 20 are used to backup and restore your current configurations. 

Finally, options 27, 28, and 29 are open options, allowing you to just give it the information that you want to block. 
Caution: Do not Set all rules to reload upon reboot without ensuring that all your services are enabled. If you choose that option and find that you can’t log in, you’re out of luck for good. 
Choose the option that you would like use, then type that number. 
 
Pressing 1, I see that I have two rules enabled – blocking Pings. This program is a loop so it will not stop until you press Q. That works in my favor since I want to disable that ping rule. 
I press D to disable, then type 2.
 
As you can see, the rules are now gone, and the program was successful. 
Satisfied, type Q to quit, and you’re now done. 
 
