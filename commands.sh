#1 +120+a
#th3-final-done-check
echo '=== GPU ==='
nvidia-smi | grep -E "MiB /|No running" | head -4
echo '=== experiments.log ==='
cat /opt/dlami/nvme/sparse_emb_outputs/logs/experiments.log 2>/dev/null
echo '=== checkpoint-10000 ==='
ls -d /opt/dlami/nvme/sparse_emb_outputs/residual_ant/checkpoint-10000 2>/dev/null && echo "EXISTS" || echo "MISSING"
echo '=== last loss ==='
grep -o "{'loss'[^}]*}" /opt/dlami/nvme/sparse_emb_outputs/logs/residual_ant.log 2>/dev/null | tail -3
echo '=== train_config ==='
ls /opt/dlami/nvme/sparse_emb_outputs/residual_ant/train_config.json 2>/dev/null && echo "EXISTS" || echo "MISSING"
echo TH3 DONE CHECK
