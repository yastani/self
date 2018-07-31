<?php
# Copyright (C) 2015  Glen Pitt-Pladdy
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
#
# See: https://www.pitt-pladdy.com/blog/_20150514-223519_0100_PHP_APC_on_Cacti_via_SNMP/
#
# This is the status script that goes with the Cacti Templates for APC via SNMP
# It can be accessed as a snmpd extension with something like:
#       extend phpapc /usr/bin/curl --silent http://localhost/apcstat.php
header('Content-Type: text/plain');
$apcstat = apc_cache_info('', True);
print "$apcstat[num_hits]\n";
print "$apcstat[num_misses]\n";
print "$apcstat[num_inserts]\n";
#print "$apcstat[num_expunges]\n";
print "$apcstat[num_entries]\n";
print "$apcstat[num_slots]\n";

#print(json_encode($apcstat));
?>