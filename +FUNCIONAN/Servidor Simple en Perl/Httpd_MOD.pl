#! perl
# Script requires 5.004 for IO::Socket
require 5.004;

use strict;
use HTTP::Daemon;
use HTTP::Status;
use HTTP::Response;
use IO::File;
use Fcntl;
use Sys::Hostname;
use IO::Handle qw(_IOFBF);

my $OSError;
if ($^O eq 'MSWin32') {
	eval "
		$OSError = sub {
			Win32::FormatMessage(Win32::GetLastError);
		};
	";
}
else {
	$OSError = sub {
		$!;
	};
}

########################################################
# Configuration info
########################################################
my $BaseDir = "c:/perl/www/";
my $LocalPort = 80;
my $CgiWeb = "/cgi-bin/";
my $CgiDir = "c:/perl/www/cgi-bin/";
$CgiDir =~ s/$CgiWeb$//;
my $CgiTemp = "c:/perl/www/";
my $LogFileDir = "c:/perl/www/";
my $LogFileName = "NCSA.log";
my $ErrFileName = "Error.log";
my $LogLinesBuffer = 100; # bytes
sub debug {1} # set to 1 for debugging
########################################################

sub logline(@); # output to server logfile
sub TRACE(@); # Debug output
sub ProcessClient($); # Process a client.
sub ProcessCGI($$); # Process a CGI Request.
sub ProcessFile($$); # Process an ordinary request.
sub ProcessPost($$); # Process a POST Request.

my $server;  # The actual http server
my $logfile; # The logfile
my $logbuffer; # The log buffer

# open(STDERR, ">>$LogFileDir$ErrFileName") || die "Can't redirect STDERR: $!";

sub closeall {
	# Ctrl-C handler
	my $signame = shift;
	undef $logfile; # Close the logfile
	undef $server;  # Close the server
}

# Open logfile
$logfile = new IO::File $LogFileDir.$LogFileName, ">>";
if (!$logfile) { die "Can't open log file: $!"; }
# Set logfile buffer
$logfile->setvbuf($logbuffer, _IOFBF, $LogLinesBuffer);

# Ctrl-C handler setup
$SIG{INT} = 'closeall';

$server = new HTTP::Daemon( LocalPort => $LocalPort,
			   Listen => SOMAXCONN,
			   Reuse => 1,
			   );

unless ($server) { die "Can't open socket connection: $!" }
TRACE "Server waiting for client connection...";
TRACE "Please contact me at: ", $server->url;

while (my ($client, $peeraddr) = $server->accept()) {
	TRACE "Receiving connection from ", $client->peerhost;
	$client->autoflush(1);
	ProcessClient($client);
	undef $client;
	$server = new HTTP::Daemon(LocalPort => $LocalPort)
	    unless defined $server
}

sub logline(@) {
    eval {
		print $logfile join ' ', @_;
    };
    warn $@ if $@;
}

sub TRACE(@) {
	if (debug) {
		my ($package, $filename, $line) = caller;
		my $time = sprintf("%02d:%02d.%02d", reverse ((localtime)[0,1,2]));
		print STDERR "$package\:\:$line $time : ", join '', @_, "\n";
	}
}

sub ProcessClient($) {
	my $client = shift;
	my $request = $client->get_request;
	my ($remip, $remlogin, $remuser, $datetime,
		$targeturl, $totalbytes, $returncode, $referer, $browser);
	if ($request) {
		foreach ($remip, $remlogin, $remuser, $datetime,
				 $targeturl, $totalbytes, $returncode, $referer, $browser) {
			$_ = '-';
		}
		$remip = $client->peerhost;
		$datetime = '[' . scalar localtime(time) . ']';
		$targeturl = join '', '"', $request->method, ' ', $request->url->path, '"';
		if ($request->method eq 'GET') {
			TRACE "Getting: ", $request->url->path;
#			TRACE "Could be: ", $request->as_string();
			if ($request->url->path =~ /^\/\.\./) {
				$client->send_error(RC_FORBIDDEN);
			}
			elsif ($request->url->path =~ /^$CgiWeb/) {
				ProcessCGI($client, $request);
			}
			else {
				ProcessFile($client, $request);
			}
		}
		elsif ($request->method eq 'POST') {
			$client->send_error(RC_NOT_IMPLEMENTED);
		}
		else {
			$client->send_error(RC_BAD_REQUEST);
		}
	}
	else {
		$client->send_error(RC_BAD_REQUEST);
	}
	logline (($remip, $remlogin, $remuser, $datetime,
			  $targeturl, $totalbytes, $returncode, $referer, $browser), "\n");
}

sub ProcessCGI($$) {
	my $client = shift;
	my $request = shift;
	my ($params);
	if (-d $CgiDir.$request->url->path) {
		$client->send_error( RC_BAD_REQUEST );
	}
	elsif (!(-e $CgiDir.$request->url->path)) {
		$client->send_error( RC_NOT_FOUND );
	}
	else {
		my $cgiCommand = $CgiDir . $request->url->path;

		TRACE "Processing CGI $cgiCommand";

		$client->send_basic_header;

		# Setup ENV.
#		local %ENV;

		$ENV{SERVER_SOFTWARE} = 'FastNetHTTPd/0.1';
		$ENV{SERVER_NAME} = Sys::Hostname::hostname();
		$ENV{GATEWAY_INTERFACE} = 'CGI/1.1';
		$ENV{SERVER_PROTOCOL} = $request->protocol;
		$ENV{SERVER_PORT} = $request->url->port;
		$ENV{REQUEST_METHOD} = $request->method;
		$ENV{QUERY_STRING} = $request->url->query;
		$ENV{REMOTE_ADDR} = $client->peerhost;
		$ENV{HTTP_ACCEPT} = $request->header('Accept');
		$ENV{HTTP_USER_AGENT} = $request->header('User_Agent');
		$ENV{SCRIPT_NAME} = $request->url->path;
		$ENV{CONTENT_LENGTH} = 0;

		my $saveout = new IO::File ">&STDOUT";

		open(STDOUT, ">&=".$client->fileno) or TRACE "Can't redirect stdout: $!";
#		select $client->fileno; # Not used - don't uncomment

#		open(CGI, $cgiCommand) or TRACE "CGI Not found";
		no strict; # Turn off strict for CGI (it might not be written with strict in mind)
#		my $_cgi = join '', <CGI>;
#		eval $_cgi;
		TRACE "do $cgiCommand with $ENV{QUERY_STRING}";
		# This processes the CGI Command
		eval {
			do $cgiCommand or TRACE "CGI failed: $@";
		};
		if ($@) {
			TRACE "CGI eval failed: ", $@;
		}
#		close CGI or TRACE "Can't close CGI: $!";
		close(STDOUT) or TRACE "Can't close STDOUT: $!";
		open(STDOUT, ">=".$saveout->fileno) or TRACE "$!";
#		select STDOUT; # Not used.

		undef $saveout;
	}
}

sub ProcessFile ($$) {
	my $client = shift;
	my $request = shift;
	my $path = $request->url->path;
	my $filename = $BaseDir . $request->url->path;
	if (-d $filename) {
		TRACE "Processing Directory: ", $filename;
		if ($path !~ /\/$/) {
			$client->send_redirect($path. "/");
		}
		else {
			if (-e $filename . "index.html") {
				TRACE "Directory $filename has index.html";
				$filename .= "index.html";
			}
		}
	}
	$client->send_file_response($filename);
}

# NCSA Log file format:
# 192.168.0.1 - - [01/Jan/1997:01:01:01 +0000] "GET /~username/page1.html HTTP/1.0" 200 122345 "http://www.ndirect.co.uk/~username/index.html" "Mozilla/3.01Gold (Win95; I)"
