# --
# TidyAll/Plugin/OTRS/Common/CustomizationMarkers.pm - code quality plugin
# Copyright (C) 2001-2013 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package TidyAll::Plugin::OTRS::Common::CustomizationMarkers;
## nofilter(TidyAll::Plugin::OTRS::Common::CustomizationMarkers)

use strict;
use warnings;

use File::Basename;

use base qw(TidyAll::Plugin::OTRS::Base);

sub validate_source {    ## no critic
    my ( $Self, $Code ) = @_;

    return $Code if $Self->IsPluginDisabled( Code => $Code );

    my ( $Counter, $Flag, $ErrorMessage );

    LINE:
    for my $Line ( split /\n/, $Code ) {
        $Counter++;

        # Allow ## no critic and ## use critic
        next if $Line =~ m{^ \s* \#\# \s+ (?:no|use) \s+ critic}xms;

        # Allow ## nofilter
        next if $Line =~ m{^ \s* \#\# \s+ nofilter }xms;

        if ( $Line =~ /^[^#]/ && $Counter < 24 ) {
            $Flag = 1;
        }
        if ( $Line =~ /^ *# --$/ && ( $Counter > 23 || ( $Counter > 10 && $Flag ) ) ) {
            $ErrorMessage .= "Line $Counter: $Line\n";
        }
        elsif ( $Line =~ /^ *# -$/ ) {
            $ErrorMessage .= "Line $Counter: $Line\n";
        }
        elsif ( $Line =~ /^ *##+ -+$/ ) {
            $ErrorMessage .= "Line $Counter: $Line\n";
        }
        elsif ( $Line =~ /^ *#+ *[\*\+]+$/ ) {
            $ErrorMessage .= "Line $Counter: $Line\n";
        }
        elsif ( $Line =~ /^ *##+/ ) {
            $ErrorMessage .= "Line $Counter: $Line\n";
        }
    }
    if ($ErrorMessage) {
        die __PACKAGE__ . "\n" . <<EOF;
Please remove or replace wrong Separators like '# --', valid only: # --- (for customizing otrs files).
$ErrorMessage
EOF
    }
    return;
}

1;
