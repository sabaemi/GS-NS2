set ns [new Simulator]

#Colors for data flows
$ns color 1 Blue
$ns color 2 Green

#Trace file
set trFile [open out.tr w]
$ns trace-all $trFile
set namFile [open out.nam w]
$ns namtrace-all $namFile

#Finish
proc finish {} {
 global ns trFile namFile
 $ns flush-trace
 close $namFile
 close $trFile
 exit 0
}

#Nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

#Links between the nodes
$ns duplex-link $n1 $n0 2Mb 15ms DropTail
$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n2 $n4 2Mb 15ms DropTail
$ns duplex-link $n4 $n3 1Mb 15ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail
$ns duplex-link $n3 $n5 1Mb 20ms DropTail
#$ns queue-limit $n0 $n2 10

#Node position
$ns duplex-link-op $n1 $n0 orient right
$ns duplex-link-op $n0 $n2 orient right
$ns duplex-link-op $n2 $n4 orient left-down
$ns duplex-link-op $n4 $n3 orient right
$ns duplex-link-op $n2 $n3 orient down
$ns duplex-link-op $n3 $n5 orient right

#UDP connection
set udp [new Agent/UDP]
$ns attach-agent $n0 $udp
set null [new Agent/Null]
$ns attach-agent $n4 $null
$ns connect $udp $null
$udp set fid_ 1
#CBR over UDP connection
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set type_ CBR
$cbr set packet_size_ 1000
$cbr set rate_ 800kb

#TCP connection
set tcp [new Agent/TCP]
$tcp set class_ 2
$ns attach-agent $n1 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n5 $sink
$ns connect $tcp $sink
$tcp set fid_ 2
#FTP over TCP connection
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP

#Scheduling
$ns at 0.1 "$cbr start"
$ns at 1.0 "$ftp start"
$ns at 4.0 "$ftp stop"
$ns at 4.5 "$cbr stop"
$ns at 5.0 "finish"
$ns run
