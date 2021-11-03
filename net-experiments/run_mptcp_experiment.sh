#!/bin/bash -x
# This runs a experiment with mptcp. And generates some graphs from it
# (packet delay variation and throughput). This is the server side (T_exit)

results_dir="MPTCP_in_tree_v5.12"   # the dir the results will be stored in
echo -e "\e[31;1m$results_dir \e[0m"
mkdir $results_dir

#----
# series_dir=MPTCP_test_2
# runtime=20
# probe_cmd=iperf
# udp_flag="-u"
# bandwith_opt="-b 18M"
# iperf_report_interval=0.1
# flowcount=1
#
# mkdir $series_dir
#----


# other_ctx_prefix="ip netns exec T_entry"
tentry_ssh_dest="root@tentry"
other_ctx_prefix="ssh $tentry_ssh_dest"

# Restart MPTCP server (openvpn via MPTCP)
# systemctl restart openvpn-server_mptcp@server.service


# Restart MPTCP client (openvpn via MPTCP) to reinitialize tcp subflows
$other_ctx_prefix  systemctl restart openvpn-client_mptcp@client
sleep 2s

timeout $((runtime+5)) tcpdump -i tun0 -w tun0_trace.pcap &
# Run iperf client to generate test traffic
$other_ctx_prefix "$probe_cmd $udp_flag  -t $runtime $bandwith_opt  \
		            -c 192.168.0.1 -i $iperf_report_interval -e -f m  -P $flowcount  &> /tmp/iperf_tentry.log" &

sleep $((runtime+13))
## ----- here we block for 13 seconds, after that

# TODO: schauen ob das hier so passt, testen, evtl. kürzen
# if we used ssh, copy log files from other host to us:
# uses bash regex matching, checks if prefx starts with "ssh "
if [[ $other_ctx_prefix =~ ^ssh[[:blank:]]  ]] ; then
    scp -q "$tentry_ssh_dest:/tmp/{*tentry*log*,time_inflight*.tsv}" .
fi

if [[ "$udp_flag" == "-u" ]] ; then
	cpdv_tsv.py udp tun0_trace.pcap
else
	cpdv_tsv.py tcp tun0_trace.pcap	
fi

rm tun0_trace.pcap

# Extract totals from iperf_tentry.log:
# grep -v "^\[SUM\]" iperf_tentry.log | grep -e " 0\.0000-[1-9][0-9]" | grep -e "ms .* ms" -e "out-of-order" > iperf_totals
# ./iperf_udp_report_aggregate.pl iperf_tentry.log > udp_aggregates.tsv

mv cpdv_flow*  iperf_tentry.log   $results_dir
mv $results_dir $series_dir

