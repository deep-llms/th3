#1 +120+a
#th3-check-progress-2
echo '=== outputs ==='
ls -la /opt/dlami/nvme/sparse_emb_outputs/ /opt/dlami/nvme/sparse_emb_outputs/logs/
echo '=== experiments.log ==='
cat /opt/dlami/nvme/sparse_emb_outputs/logs/experiments.log
echo '=== latest loss lines ==='
for f in /opt/dlami/nvme/sparse_emb_outputs/logs/*.log; do
    echo "--- $f ---"
    grep -o "{'loss'[^}]*}" "$f" | tail -3
done
echo '=== last checkpoint ==='
ls -d /opt/dlami/nvme/sparse_emb_outputs/ant_ours/checkpoint-* 2>/dev/null | sort -V | tail -3
echo '=== gpu ==='
nvidia-smi | head -12
