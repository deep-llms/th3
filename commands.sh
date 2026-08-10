#1 +120+a
#th3-eval-status-1
echo '=== eval_parallel progress ==='
tail -25 eval_parallel.log 2>/dev/null
echo '=== eval procs ==='
pgrep -af "eval_parallel|eval_checkpoint" | head -5 || echo "no eval processes"
echo '=== results so far ==='
ls /opt/dlami/nvme/sparse_emb_outputs/ant_ours/checkpoint-*/eval_ppl.json /opt/dlami/nvme/sparse_emb_outputs/ant_ours/checkpoint-*/eval_benchmarks.json 2>/dev/null
echo '=== gpu ==='
nvidia-smi | grep -E "MiB /" | head -8
