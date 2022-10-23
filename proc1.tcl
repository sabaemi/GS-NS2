proc Factorial {x} {
 set output 1
 for {set i 1} {$i <= $x} {incr i} {
 set output [expr $output * $i]
 }
 return $output
}

proc proc1 {n k} {
 set a [Factorial $n]
 set b [expr $n*$k] 
 set res [expr $a+$b]
 return $res
} 

puts "Enter n"
gets stdin n
puts "Enter k"
gets stdin k
set sum [proc1 $n $k]

puts "reslt is $sum"
