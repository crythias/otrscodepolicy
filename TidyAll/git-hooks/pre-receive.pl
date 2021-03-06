#!/usr/bin/perl
# --
# TidyAll/git-hooks/pre-receive.pl - git pre receive hook
# Copyright (C) 2001-2014 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;

use File::Basename;
use FindBin qw($RealBin);
use lib dirname($RealBin) . '/../';
use lib dirname($RealBin) . '/../Kernel/cpan-lib';

use TidyAll::OTRS::Git::PreReceive;

my $PreReceive = TidyAll::OTRS::Git::PreReceive->new();
$PreReceive->Run();
