#1 +120+a
#th3-probe-bytoken-progress
O=/opt/dlami/nvme/sparse_emb_outputs
echo '=== procs ==='
pgrep -af "ppl_bytoken|count_token" || echo none
echo '=== gpu ==='
nvidia-smi | grep -E "MiB /" | head -4
echo '=== ant_ours log tail ==='
tail -c 1500 $O/ant_ours/checkpoint-10000/ppl_bytoken.log
echo
echo '=== baseline log tail ==='
tail -c 1500 $O/baseline/checkpoint-10000/ppl_bytoken.log
echo
echo '=== freq log tail ==='
tail -c 2000 $O/token_freq.log
