
set terminal pdfcairo # mono
set output "throughput_sums_LLMT.pdf"
set title "Total throughput transported via the MT System"
set ylabel "Mbytes"
unset xlabel

set style fill solid 
set style data boxes
set boxwidth  0.5
unset key

# Example data line (last line of iperf output)
# [SUM] 0.0000-70.3565 sec   122 MBytes  14.5 Mbits/sec  1061/4       868

# throughput sum in Mbyte is in 4th column (counting starting at 1)

plot  '<grep -v "^\[ CT\]" otias_sock_drop/iperf_tentry.log | tail -n 1'          using  (1.0):(column(4)):xtic("OTIAS")  \
,     '<grep -v "^\[ CT\]" afmt_fl/iperf_tentry.log | tail -n 1'       using  (1.75):(column(4)):xtic("AFMT") \
,     '<grep -v "^\[ CT\]" srtt_min_busy_wait/iperf_tentry.log | tail -n 1'       using  (2.5):(column(4)):xtic("LowRTT") \
,     '<grep -v "^\[ CT\]" llfmt_noqueue_busy_wait/iperf_tentry.log | tail -n 1'   using  (3.25):(column(4)):xtic("LLMT")   \
,     "" 					    using  (0.5):2:(0)  \
,     "" 					    using  (3.75):2:(0)  \


