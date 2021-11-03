#!/bin/bash


ig0_rtt=40
ig1_rtt=60
ig2_rtt=80


echo "Setting path characteristics on all subtunnel paths..."
# ig0
ssh root@ig0 "tc qdisc change dev eth0.11 root netem delay $((ig0_rtt/2))ms "
ssh root@ig0 "tc qdisc change dev eth0.21 root netem delay $((ig0_rtt/2))ms "

# ig1
ssh root@ig1 "tc qdisc change dev eth0.12 root netem delay $((ig1_rtt/2))ms "
ssh root@ig1 "tc qdisc change dev eth0.22 root netem delay $((ig1_rtt/2))ms "

# ig2
ssh root@ig2 "tc qdisc change dev eth0.13 root netem delay $((ig2_rtt/2))ms "
ssh root@ig2 "tc qdisc change dev eth0.23 root netem delay $((ig2_rtt/2))ms "


echo "Done!"



