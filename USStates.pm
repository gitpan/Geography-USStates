# -------------------------------------------------------------------------
# Name: Geography::USStates.pm
# Auth: Dion Almaer (dion)
# Desc: Get info on US States
# Date Created: Sun Nov 15 17:50:29 1998
# Version: 0.10
# $Modified: Tue Dec 15 12:16:05 1998 by dion $
# -------------------------------------------------------------------------
package Geography::USStates;

use     strict;
require 5.002;
require Exporter;

$Geography::USStates::VERSION = '0.10';
@Geography::USStates::ISA     = qw(Exporter);
@Geography::USStates::EXPORT  = qw(getState getStates 
				  getStateNames getStateAbbrevs);

%Geography::USStates::STATES = 
                  (AL => 'Alabama', AK => 'Alaska', AZ => 'Arizona', 
                   AR => 'Arkansas', CA => 'California', CO => 'Colorado', 
                   CT => 'Connecticut', DE => 'Delaware', 
                   DC => 'District of Columbia', FL => 'Florida',
                   GA => 'Georgia', HI => 'Hawaii', ID => 'Idaho', 
                   IL => 'Illinois', IN => 'Indiana', IA => 'Iowa', 
                   KS => 'Kansas', KY => 'Kentucky', 
		   LA => 'Louisiana', ME => 'Maine', MD => 'Maryland', 
		   MA => 'Massachusetts', MI => 'Michigan', MN => 'Minnesota',
		   MS => 'Mississippi', MO => 'Missouri', MT => 'Montana', 
		   'NE' => 'Nebraska', NH => 'New Hampshire',
                   NV => 'Nevada', NM => 'New Mexico', NY => 'New York', 
                   NC => 'North Carolina', ND => 'North Dakota', OH => 'Ohio', 
                   OK => 'Oklahoma', OR => 'Oregon', PA => 'Pennsylvania', 
                   RI => 'Rhode Island', SC => 'South Carolina', 
                   SD => 'South Dakota', TN => 'Tennessee', TX => 'Texas', 
                   UT => 'Utah', VT => 'Vermont', VA => 'Virginia', 
                   WA => 'Washington', WV => 'West Virginia', WI => 'Wisconsin',                   WY => 'Wyoming');

# ----------------------------------------------------------------------------
# Subroutine: getState - given abbrev get full name, given name get abbrev
# ----------------------------------------------------------------------------
sub getState {
   my $value = shift;
   if (length $value > 2) {
       my %states = getStates('case' => 'lower', 'hashkey' => 'name');
       return $states{lc $value};
   } else {
       return $Geography::USStates::STATES{uc $value};
   }
}

# ----------------------------------------------------------------------------
# Subroutine: getStates - return a states hash: $hash{'MN'} = 'Minnesota'
# ----------------------------------------------------------------------------
sub getStates { 
   my %hash = (ref $_[0] eq 'HASH') ? %{ $_[0] } : @_;

   # -- do something to the states 
   $hash{hashkey} ||= ''; # -- for -w
   $hash{case}    ||= ''; # -- for -w
 
   return %Geography::USStates::STATES 
          unless @_ || $hash{case} || $hash{hashkey} eq 'name';

   my %states;
   while ( my ($abbrev, $name) = each %Geography::USStates::STATES ) {
           if ($hash{case} =~ /^[lu]/i) {
               $name = ($hash{case} =~ /^u/i) ? uc $name : lc $name;
           }
           if ($hash{hashkey} eq 'name') {        
               $states{$name}   = $abbrev;
           } else {
               $states{$abbrev} = $name;
           }
   }
   return %states;
}


# ----------------------------------------------------------------------------
# Subroutine: getStateNames - return an array of states by name
# ----------------------------------------------------------------------------
sub getStateNames   { return sort values %Geography::USStates::STATES; }

# ----------------------------------------------------------------------------
# Subroutine: getStateAbbrevs - return an array of states by 2 letter abbrev
# ----------------------------------------------------------------------------
sub getStateAbbrevs { return sort keys %Geography::USStates::STATES; }

# ----------------------------------------------------------------------------
1; # End of Geography::USStates.pm
# ----------------------------------------------------------------------------

__END__

=head1 NAME

Geography::USStates - USA State Data

=head1 SYNOPSIS

use Geography::USStates;

$state = getState('mn');        # -- get the statename 'Minnesota'

$state = getState('wisconsin'); # -- get the abbreviation 'wi'

@states = getStateNames();      # -- return all state names

@states = getStateAbbrevs();    # -- return all abbrevations

%s = getStates();               # -- return hash $states{'MN'} = 'Minnesota'

%s = getStates(case=>'upper');  # -- return hash $states{'MN'} = 'MINNESOTA'

%s = getStates(case=>'lower');  # -- return hash $states{'MN'} = 'minnesota'

%s = getStates(hashkey=>'name');# -- return hash $states{'Minnesota'} = 'MN'

=head1 DESCRIPTION

This module allows you to get information on US State names, their
abbreviations, and couple the two together (in hashes)

=head1 FUNCTIONS

o B<getState>($statename || $stateabbrev)

  Given an abbreviation a statename is returned.
  Given a name an abbreviatin is returned

  e.g. print getState('MN');
       would print 'Minnesota'

       print getState('wisconsin');
       would print 'WI'

o B<getStateNames>()

  Return all of the states in an array 

  e.g. map { print "$_\n" } getStateNames();
       would print "Alabama\nAlaska\n...";

o B<getStateAbbrevs>()

  Return all of the abbrevs in an array

  e.g. map { print "$_\n" } getStateAbbrevs();
       would print "AL\nAK\n...";

o B<getStates>(%hash | $hashref) [keys: case => upper||lower, hashkey=>name]

  A hash is returned with both abbrev and statename. By default it returns
  the state abbrev as the key and the state name as the value

  e.g. $hash{MN} = 'Minnesota';

  You can also pass params in a hash or hashref. To force the state names
  to be lower case, or upper case you do:

  getStates(case => 'upper'); # -- for upper case... lower for lower case

  If you want to return a hash where the name is the key you do:

  my %s = getStates(hashkey => 'name');
  and then
  $s{'Minnesota'} = 'MN';

=head1 AUTHOR

Dion Almaer (dion@member.com)

=cut

