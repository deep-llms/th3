#1 +120+a
#th3-running-ok
echo '=== gpu ==='
nvidia-smi | grep -E "MiB /" | head -4
echo '=== training process ==='
pgrep -af "run_experiments\|train_compositional\|accelerate" | grep -v pgrep | head -3 || echo "no training processes"
echo '=== experiments.log ==='
cat /opt/dlami/nvme/sparse_emb_outputs/logs/experiments.log 2>/dev/null || echo "empty"
echo '=== latest loss ==='
grep -o "{'loss'[^}]*}" /opt/dlami/nvme/sparse_emb_outputs/logs/residual_ant.log 2>/dev/null | tail -2
echo '=== latest checkpoint ==='
ls -d /opt/dlami/nvme/sparse_emb_outputs/residual_ant/checkpoint-* 2>/dev/null | sort -V | tail -3
