#1 +120+a
#th3-post-wait-verify
echo '=== GPU ==='
nvidia-smi | grep -E "MiB /|No running" | head -4
echo '=== experiments.log ==='
cat /opt/dlami/nvme/sparse_emb_outputs/logs/experiments.log 2>/dev/null
echo '=== residual_ant checkpoints ==='
ls -d /opt/dlami/nvme/sparse_emb_outputs/residual_ant/checkpoint-* 2>/dev/null | sort -V | tail -3
echo '=== last loss ==='
grep -o "{'loss'[^}]*}" /opt/dlami/nvme/sparse_emb_outputs/logs/residual_ant.log 2>/dev/null | tail -3
echo '=== processes ==='
pgrep -af "run_experiments\|train\|python" | grep -v pgrep | grep -v networkd | grep -v unattended | head -3 || echo "none"
echo TH3 VERIFY DONE
