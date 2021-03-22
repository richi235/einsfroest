
set terminal pdfcairo # mono
set output "udp_throughput_sum.pdf"
set title "Sum of UDP Throughput"
set ylabel "Mbit/s"
unset xlabel

set style fill solid 
set style data boxes
set boxwidth  0.5
unset key

plot  "otias_sock_drop/udp_aggregates.tsv"          using  (1.0):(column(1)):xtic("OTIAS")  \
,     "afmt_fl/udp_aggregates.tsv"                  using  (1.75):(column(1)):xtic("AFMT")   \
,     "srtt_min_busy_wait/udp_aggregates.tsv"       using  (2.5):(column(1)):xtic("LowRTT") \
,     "llfmt_noqueue_busy_wait/udp_aggregates.tsv"  using  (3.25):(column(1)):xtic("LLMT")   \
,     "" 					    using  (0.5):2:(0)  \
,     "" 					    using  (3.75):2:(0)  \
