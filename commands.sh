#1 +120+a
#th3-confirm-training
echo '=== run status tail ==='
tail -3 _RUN_STATUS_.log
echo '=== experiments.log ==='
cat /opt/dlami/nvme/sparse_emb_outputs/logs/experiments.log 2>/dev/null || echo "empty"
echo '=== residual_ant dir ==='
ls -la /opt/dlami/nvme/sparse_emb_outputs/residual_ant/ 2>/dev/null | head -10 || echo "NOT EXIST"
echo '=== first loss lines ==='
grep -o "{'loss'[^}]*}" /opt/dlami/nvme/sparse_emb_outputs/logs/residual_ant.log 2>/dev/null | head -5
echo '=== last loss lines ==='
grep -o "{'loss'[^}]*}" /opt/dlami/nvme/sparse_emb_outputs/logs/residual_ant.log 2>/dev/null | tail -3
echo '=== gpu ==='
nvidia-smi | grep -E "MiB /" | head -4
