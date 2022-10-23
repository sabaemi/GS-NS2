proc max {x y} {
 if {$x >= $y} {return $x} else {return $y}
}

proc max_num {a b c d} {
 set left_max [max $a $b]
 set right_max [max $c $d]
 set final_max [max $left_max $right_max]
 return $final_max
}

puts "Enter a"
gets stdin a
puts "Enter b"
gets stdin b
puts "Enter c"
gets stdin c
puts "Enter d"
gets stdin d
set maximum [max_num $a $b $c $d]
puts "maximum number is $maximum"
