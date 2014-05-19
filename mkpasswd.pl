#!/usr/bin/perl
print "solt:";
chomp($solt = <STDIN>);
print "password:";
chomp($passwd = <STDIN>);
$hash = crypt("$passwd", "\$6\$$solt");
print "$hash";

open(FH, "> password");
print FH $hash;
close(FH);
