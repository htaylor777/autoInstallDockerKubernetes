#!/usr/bin/perl


$num = 95;

 @ranges=(73..80, 92..107, 941..1000, 3000..3170);

foreach $r (@ranges) {
   $min = ($ranges[0]);
   $max = pop(@ranges);
   print "$num --> $r\n";
     if ($num == $r){
     print "$num was found in range $min..$max\n";
      }
    }
