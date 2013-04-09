#!/usr/bin/perl -w

# BansheeX - Simple script for using Banshee in Xchat
# Copyright (C) 2013  Auze <twitter: @Auze_>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

use strict;
use Xchat qw( :all);

# Register plugin in Xchat
register('BansheeX', '0.1', 'Simple Script for using Banshee in Xchat');

# Welcome Message
command("echo ###########");
command("echo BansheeX Script 0.1");
command("echo Simple Script for using Banshee in Xchat");
command("echo Author : Auze @ Absylonia");
command("echo /bhelp pour la liste des commandes");
command("echo ###########");

# Command list and function
hook_command('bcur', \&bcur);
hook_command('bplay',\&bplay);
hook_command('bpause',\&bpause);
hook_command('bnext', \&bnext);
hook_command('bvers',\&bvers);
hook_command('bprev',\&bprev);
hook_command('btest',\&btest);
hook_command('bhelp', \&help);
 
 # Display current track if running
sub bcur {
	
	my $run = &btest();
	
	if ($run == 0) {
	
		my $rawtitle = substr(`banshee --query-title`, 7);
		my $title = substr($rawtitle,0, length($rawtitle) -1);
		
		my $rawartist = substr(`banshee --query-artist`, 8);
		my $artist = substr($rawartist,0,length($rawartist) -1);
		
		my $rawalbum = substr(`banshee --query-album`, 7);
		my $album= substr($rawalbum,0,length($rawalbum) -1);
		
		my $rawversion = `banshee --version`;
		my $version = substr($rawversion,0,11);
		
		my $rawstatus = substr(`banshee --query-current-state`, 15);
		my $status = substr($rawstatus,0,length($rawstatus) -1);
		
		my $listening ="\cC04[$version : $status] \cC09$title"." \cC04par \cC09$artist"." \cC04sur \cC09$album";
		command("me  $listening");
	}
}

# Play the current track
sub bplay {
	`banshee --play`;
	command ("echo C'est parti !");
}

# Pause Banshee
sub bpause {
	`banshee --pause`;
	command("echo Banshee en pause");
}

# Next track
sub bnext {
	`banshee --next`;
	command("echo Morceau suivant");
}

# Previous track
sub bprev {
	`banshee --previous`;
	command("echo Morceau précédent")
}

# Display Banshee version
sub bvers {
	my $rawversion = `banshee --version`;
	my $version = substr($rawversion,0,11);
	command("echo $version");
}

# Test if Banshee curently running
sub btest {
	`pidof banshee`;
	my $btest = $?;
	if ($btest == 0) { 
		return 0;
	}
	else {
		command("echo Banshee n'est pas lancé actuellement !");
		return 1;
	}
}

# Display list of BansheeX command
sub help {
	command("echo Liste des commandes disponibles :");
	command("echo bhelp - Affiche cette page d'aide");
	command("echo bcur - Affiche la piste en cours de lecture");
	command("echo bplay - Lire le morceau");
	command("echo bpause - Mettre le lecteur en pause");
	command("echo bnext - Passe au morceau suivant");
	command("echo bprev - Retourne au morceau précédent");
	command("echo bvers - Affiche la version de banshee");
	command("echo btest - Vérifie le lancement de Banshee (Ne retourne rien si lancé)");
}

