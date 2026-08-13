#1 +120+a
#th3-check-running
echo '=== GPU processes ==='
nvidia-smi | grep -E "MiB /|No running|python" | head -12
echo '=== training/eval processes ==='
pgrep -af "python|accelerate|run_experiments|train" | grep -v pgrep | grep -v networkd | grep -v unattended | head -10 || echo "no processes"
echo '=== residual_ant training status ==='
cat /opt/dlami/nvme/sparse_emb_outputs/logs/experiments.log 2>/dev/null
echo '=== residual_ant latest checkpoints ==='
ls -d /opt/dlami/nvme/sparse_emb_outputs/residual_ant/checkpoint-* 2>/dev/null | sort -V | tail -3
echo '=== residual_ant last loss ==='
grep -o "{'loss'[^}]*}" /opt/dlami/nvme/sparse_emb_outputs/logs/residual_ant.log 2>/dev/null | tail -3
echo TH3 CHECK DONE
