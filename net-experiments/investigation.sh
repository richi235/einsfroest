#!/bin/bash

# In our lingo a series is a number of experiments, all with the same network configuration
# evaluating several different scheduling algorithms (5-6). experiment_series.sh is responsible
# for running such a series

# This script makes it possible to set network configuration, run a series, change network
# configuration, run another series etc. to give a maximum of automatiton benefit :)

# You have to use this as entry points for all experiments, calling experiment_series.sh
# is no longer possible


# Was ich über dieses script noch nicht ändern/automatisieren kann:
#  - CCID einstelllung
#  - wie viele tunnels wir benutzen


# [90%]: noch entscheiden wie ich das sinnvoll mit prefixes und unterordnen mache
# TODO entscheiden was ich mit run variable mache
# TODO [B] evtl. alles in funkitonen packen
# TODO [B] überlegen wie man fancy wiederholungen macht
# TODO [B] überlegen wie man fancy verschachtelete ordnerstruktur bekommt
# TODO [B] überlegen wie man overall uhr/progress info kriegt
# TODO [B] überlegen wie man CCID ändern kann
# TODO [B] überlegen wie man subtunnel anzahl ändern kann
#    - evtl. eigenes script auf tentry das mpvpn config ändert (3. subtunnel toggled), dann hier callen

investigation_prefix=cpdv_udp_1_flow_20M_3

# If the investigation dir already exists, append a _
if [[ -e $investigation_prefix ]] ; then 
	investigation_prefix=${investigation_prefix}_
fi	


runtime=60
warmup_seconds=10
flowcount=1
# run=r6_newtimeinlog
udp_flag="-u"
len_opt="-l 1390"
bandwith_opt="-b20m"
hdr_opt= #"-hdr"
CCID=2
send_buffer_size=5 # in packets
tuncount=3

ig0_rtt=50    # in ms
ig0_rate=8mbit

ig1_rtt=70
ig1_rate=8mbit

ig2_rtt=50
ig2_rate=8mbit

source ./experiment_series.sh


mkdir $investigation_prefix
mv ${investigation_prefix}:*  $investigation_prefix

# Remove the prefix from the series directory names 
# and do __ --> _ substitution
cd $investigation_prefix
rename -E "s/${investigation_prefix}://" -E "s/__/_/g"   ${investigation_prefix}:*
cd ..

cp "$(readlink -f $0)" $investigation_prefix # archive this script too, as reference

echo -e "\e[42;1mInvestigation $investigation_prefix finished \e[0m"
