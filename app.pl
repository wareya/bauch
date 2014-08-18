#!/usr/bin/perl
use strict;
use warnings;

use HTML::Template;
use JSON;           #intermediary between DB and templating
use File::Slurp;    #json from test file

my $app = sub {
	my $pagetmpl = HTML::Template->new(filename => 'pagetemplate.html');
	my $posttmpl = HTML::Template->new(filename => 'posttemplate.html');
    my $optmpl   = HTML::Template->new(filename => 'optemplate.html');
    
    my $threadjson = read_file("tmp.json");
	my $threaddata = decode_json($threadjson);
	
    my $subject = %$threaddata{"subject"};
	$optmpl->param('post_title' => $subject);
    
    my $posts = "";
    my $tmpl = $optmpl;
    
    
	foreach my $postid (@{%$threaddata{"posts"}})
	{
	    my $post = $postid;
    	$tmpl->param('poster_name' => $post->{"poster"});
    	$tmpl->param('poster_tripcode' => $post->{"tripcode"});
    	$tmpl->param('postimage_as_tag' => $post->{"icon_as_html"});
    	$tmpl->param('postdata' => $post->{"data"});
		$posts = $posts . $tmpl->output;
        
        $tmpl = $posttmpl;
        
        $tmpl->clear_params();
	};
	$pagetmpl->param('postlisting' => $posts);
    return [
        '200',
        [ 'Content-Type' => 'text/html' ],
        [ $pagetmpl->output ],
    ];
};