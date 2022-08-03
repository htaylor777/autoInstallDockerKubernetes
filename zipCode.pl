#!/usr/bin/perl

use List::Util qw(max min);



$Zranges="73555..73999,80000..80199,94133..94134,94200..94299,94600..94699";
@zipcoderanges=(73555..73999, 80000..80199, 94133..94134, 94200..94299, 94600..94699);
##@zipcoderanges=(73555..73999);

##main();

#foreach $z (@zipcoderanges){
# @ziprange = split(/:/,$z);
#print "$ziprange[0]..$ziprange[1]\n";
#}

 $searchnum = 73557;

@d = split(/,/,$Zranges);
     foreach $d (@zipcoderanges) {
   print "HEEE:(@zipcoderansges[1]) (@zipcoderanges[2])\n";
    push(@ranges,$d);
##print "SEE: $d\n";
}
##print "TEST: @ranges\n";
            ##  @ranges=($d);

                 foreach $r (@ranges) {
                 $thismin = min(@ranges);
                 $thismax = max(@ranges);
              ##  print "HERE: $r\n";
                 if ($searchnum == $r){
                 print "$searchnum was found in range $thismin..$thismax\n";
                 }
                }




sub main {
clear;
print "zip code ranges set: $Zranges\n";
