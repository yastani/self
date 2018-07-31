#!/usr/bin/python
# Copyright (C) 2009  Glen Pitt-Pladdy
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
# See: https://www.pitt-pladdy.com/blog/_20091114-134615_0000_Apache_stats_on_Cacti_via_SNMP_/

CACHETIME = 30
CACHEFILE = '/var/local/snmp/cache/apache'

# check for cache file newer CACHETIME seconds ago
import os
import time
if os.path.isfile ( CACHEFILE ) \
  and ( time.time() - os.stat ( CACHEFILE )[8] ) < CACHETIME:
  # use cached data
  f = open ( CACHEFILE, 'r' )
  data = f.read()
  f.close()
else:
  # grab the status URL (fresh data)
  # need debian package python-urlgrabber
  from urlgrabber import urlread
  data = urlread ( 'http://localhost/server-status?auto',
          user_agent = 'SNMP Apache Stats' )
  # write file
  f = open ( CACHEFILE+'.TMP.'+`os.getpid()`, 'w' )
  f.write ( data )
  f.close()
  os.rename ( CACHEFILE+'.TMP.'+`os.getpid()`, CACHEFILE )


# dice up the data
scoreboardkey = [ '_', 'S', 'R', 'W', 'K', 'D', 'C', 'L', 'G', 'I', '.' ]
params = {}
for line in data.splitlines():
  fields = line.split( ': ' )
  if fields[0] == 'Scoreboard':
    # count up the scoreboard into states
    states = {}
    for state in scoreboardkey:
        states[state] = 0
    for state in fields[1]:
      states[state] += 1
  elif fields[0] == 'Total kBytes':
    # turn into base (byte) value
    params[fields[0]] = int(fields[1])*1024
  else:
    # just store everything else
    #params[fields[0]] = fields[1]
    params[fields[0]] = 'localhost'

# output the data in order (this is because some platforms don't have them all)
dataorder = [
  'Total Accesses',
  'Total kBytes',
  'CPULoad',
  'Uptime',
  'ReqPerSec',
  'BytesPerSec',
  'BytesPerReq',
  'BusyWorkers',
  'IdleWorkers'
]
for param in dataorder:
  try:
    print params[param]
  except: # not all Apache's have all stats
    print 'U'

# print the scoreboard
for state in scoreboardkey:
  print states[state]