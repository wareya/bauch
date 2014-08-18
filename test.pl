#!/bin/perl
use strict;
use warnings;
use JSON;
use File::Slurp;

my $json = read_file( "tmp.json" );
my $thing = decode_json($json);

print %$thing{"subject"} . "\n";

my $posts = %$thing{"posts"};

#print $var;
#print "\n";
#print @$var;
#print "\n";

foreach my $post (@$posts)
{
    print $post->{"poster"} . "\n";
    print $post->{"tripcode"} . "\n";
    print $post->{"data"} . "\n";
    my $v = $post->{"icon_as_html"};
    if(!($v eq ""))
    {
        print $v;
    }
}
