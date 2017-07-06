package RT::Authen::Token;
use strict;
use warnings;

our $VERSION = '0.01';

RT::System->AddRight(Staff => ManageAuthTokens => 'Manage authentication tokens');

use RT::AuthToken;
use RT::AuthTokens;

=head1 NAME

RT-Authen-Token - token-based authentication

=head1 INSTALLATION

RT-Authen-Token requires version RT 4.2.0 or later.

=over

=item perl Makefile.PL

=item make

=item make install

This step may require root permissions.

=item Edit your /opt/rt4/etc/RT_SiteConfig.pm

Add this line:

    Plugin( "RT::Authen::Token" );

=item Restart your webserver

=back

=head1 AUTHOR

Best Practical Solutions, LLC E<lt>modules@bestpractical.comE<gt>

=head1 BUGS

All bugs should be reported via email to

    L<bug-RT-Authen-Token@rt.cpan.org|mailto:bug-RT-Authen-Token@rt.cpan.org>

or via the web at

    L<rt.cpan.org|http://rt.cpan.org/Public/Dist/Display.html?Name=RT-Authen-Token>.

=head1 COPYRIGHT

This extension is Copyright (C) 2017 Best Practical Solutions, LLC.

This is free software, licensed under:

  The GNU General Public License, Version 2, June 1991

=cut

1;
