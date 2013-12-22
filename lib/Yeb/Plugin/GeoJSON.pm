package Yeb::Plugin::GeoJSON;
# ABSTRACT: Yeb Plugin for JSON response

use Moo;
use Geo::JSON::Simple;

has app => ( is => 'ro', required => 1 );

sub BUILD {
  my ( $self ) = @_;
  $self->app->register_function('geojson',sub {
    my $object = shift;
    $self->app->cc->content_type('application/json');
    $self->app->cc->body($object->to_json);
    $self->app->cc->response;
  });
  for my $func (@Geo::JSON::Simple::EXPORT) {
    $self->app->register_function($func,sub { &{\&{$func}}(@_) });
  };
}

1;

=encoding utf8

=head1 SYNOPSIS

=head1 FRAMEWORK FUNCTIONS

=head2 geojson

=head1 SUPPORT

IRC

  Join #duckduckgo on irc.freenode.net. Highlight Getty for fast reaction :).

Repository

  http://github.com/Getty/p5-yeb-plugin-geojson
  Pull request and additional contributors are welcome
 
Issue Tracker

  http://github.com/Getty/p5-yeb-plugin-geojson/issues


