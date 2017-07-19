package RT::Authen::Token;
use strict;
use warnings;

our $VERSION = '0.01';

RT::System->AddRight(Staff => ManageAuthTokens => 'Manage authentication tokens');

use RT::AuthToken;
use RT::AuthTokens;

RT->AddStyleSheets("rt-authen-token.css");
RT->AddJavaScript("rt-authen-token.js");

sub UserForAuthString {
    my $self = shift;
    my $authstring = shift;
    my $user = shift;

    my ($user_id, $cleartext_token) = RT::AuthToken->ParseAuthString($authstring);
    return unless $user_id;

    my $user_obj = RT::CurrentUser->new;
    $user_obj->Load($user_id);
    return if !$user_obj->Id || $user_obj->Disabled;

    if (length $user) {
        my $check_user = RT::CurrentUser->new;
        $check_user->Load($user);
        return unless $check_user->Id && $user_obj->Id == $check_user->Id;
    }

    my $tokens = RT::AuthTokens->new(RT->SystemUser);
    $tokens->LimitOwner(VALUE => $user_id);
    while (my $token = $tokens->Next) {
        if ($token->IsToken($cleartext_token)) {
            $token->UpdateLastUsed;
            return ($user_obj, $token);
        }
    }

    return;
}

=head1 NAME

RT-Authen-Token - token-based authentication

=head1 INSTALLATION

RT-Authen-Token requires version RT 4.2.5 or later.

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
