#!/usr/bin/perl 
use Data::Dumper;
use DBI;
use CGI;
use JSON;
use strict;
my $q=new CGI();
print $q->header();
#print "<h2>CIPCO Roster</h2>";
my %params  = $q->Vars;
my $query= $params{'query'};
#print $query;
my $db ="Roster";
my $user = "root";
my $pass = "";

my $host="localhost";
my $dbh = DBI->connect("DBI:mysql:$db:$host", $user, $pass);
	my $sqlQuery  = $dbh->prepare($query) or print "Can't prepare $query: $dbh->errstr\n";
	my $rv = $sqlQuery->execute() or print "can't execute the query $query: $sqlQuery->errstr";

my $numFields=$sqlQuery->{'NUM_OF_FIELDS'};
my $ref;
my $cols= $sqlQuery->{NAME};
my $data=$sqlQuery->fetchall_arrayref();
	 $ref->{cols}=$cols;
         $ref->{data}=$data;

       # print Dumper $ref;

print to_json($ref);
