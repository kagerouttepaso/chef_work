#!/usr/bin/perl
print "password:";
chomp($passwd = <STDIN>);
print "solt:";
chomp($solt = <STDIN>);
$hash = crypt("$passwd", "\$6\$$solt");
print "$hash";

open(FH, "> password");
print FH $hash;
close(FH);
