set val(chan)   Channel/WirelessChannel
set val(prop)   Propagation/TwoRayGround
set val(netif)  Phy/WirelessPhy
set val(mac)    Mac/802_11
set val(ifq)    Queue/DropTail/PriQueue
set val(ll)     LL
set val(ant)    Antenna/OmniAntenna
set val(x)      500
set val(y)      500
set val(ifqlen) 50
set val(nn)     2
set val(stop)   20.0
set val(rp)     DSDV


set ns [new Simulator]
$ns trace-all [open 8.tr w]

set namtrace [open 8.nam w]
$ns namtrace-all-wireless $namtrace $val(x) $val(y)

set prop [new $val(prop)]

set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)

create-god $val(nn)

#Node Configuration                 

        $ns node-config -adhocRouting $val(rp) \
             -llType $val(ll) \
             -macType $val(mac) \
             -ifqType $val(ifq) \
             -ifqLen $val(ifqlen) \
             -antType $val(ant) \
             -propType $val(prop) \
             -phyType $val(netif) \
             -channelType $val(chan) \
             -topoInstance $topo \
             -agentTrace ON \
             -routerTrace ON \
             -macTrace ON

#Creating Nodes                     
for {set i 0} {$i < $val(nn) } {incr i} {
     set node($i) [$ns node]    
    $node($i) random-motion 0    
     }

#Initial Positions of Nodes            

for {set i 0} {$i < $val(nn)} {incr i} {
    $ns initial_node_pos $node($i) 40
}

#Topology Design                 

$ns at 1.1 "$node(0) setdest 310.0 10.0 20.0"
$ns at 1.1 "$node(1) setdest 10.0 310.0 20.0"

#Generating Traffic                

   set tcp0 [new Agent/TCP]
   set tcpSink0 [new Agent/TCPSink]
   $ns attach-agent $node(0) $tcp0
   $ns attach-agent $node(1) $tcpSink0
   $ns connect $tcp0 $tcpSink0
   set ftp0 [new Application/FTP]
   $ftp0 attach-agent $tcp0
   $ns at 1.0 "$ftp0 start" 
   $ns at 18.0 "$ftp0 stop"

#Simulation Termination                 

for {set i 0} {$i < $val(nn) } {incr i} {
    $ns at $val(stop) "$node($i) reset";
}
$ns at $val(stop) "puts \"NS EXITING...\" ; $ns halt"

puts "Starting Simulation..."
proc finish { } {
	global ns namtrace
	$ns flush-trace
	close namtrace
	exit 0
}
ns at 20.0 "finish"
$ns run

