#!/usr/local/bin/perl5.004 

use Geography::USStates;
BEGIN { print "1..6\n"; }

my ($state, @states, %states);

print "1. Getting Statename from abbreviation\n";
$state = getState('mn');
print 'not ' unless $state eq 'Minnesota';
print "ok 1\n";

print "2. Getting State abbreviation from name\n";
$state = getState('wisconsin');
print 'not ' unless $state eq 'WI';
print "ok 2\n";

print "3. Getting All State Names\n";
@states = getStateNames();
print 'not ' unless scalar @states == 50;
print "ok 3\n";

print "4. Getting All States in a hash\n";
%states = getStates();
print 'not ' unless $states{'MN'} eq 'Minnesota';
print "ok 4\n";

print "5. Getting All Uppercase States in a hash\n";
%states = getStates(case => 'upper');
print 'not ' unless $states{'MN'} eq 'MINNESOTA';
print "ok 5\n";

print "6. Getting All lowercase States in a hash with the name as key\n";
%states = getStates(case => 'lower', hashkey => 'name');
print 'not ' unless $states{'minnesota'} eq 'MN';
print "ok 6\n";

# ----------------------------------------------------------------------------
#      End of Program
# ----------------------------------------------------------------------------
