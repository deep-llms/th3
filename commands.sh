#1 +120+a
#th3-verify-clean
echo '=== GPUs ==='
nvidia-smi | grep -E "MiB /|No running"
echo '=== processes ==='
pgrep -af "python|accelerate|train" | grep -v pgrep | grep -v networkd | grep -v unattended | head -5 || echo "no processes"
echo '=== residual_ant dir ==='
ls -d /opt/dlami/nvme/sparse_emb_outputs/residual_ant 2>/dev/null && echo "EXISTS" || echo "NOT EXIST"
echo '=== lowrank dir ==='
ls -d /opt/dlami/nvme/sparse_emb_outputs/lowrank 2>/dev/null && echo "EXISTS" || echo "NOT EXIST"
echo '=== HF cache ==='
du -sh ~/.cache/huggingface/datasets 2>/dev/null || echo "NO CACHE"
echo '=== data cache count ==='
find /opt/dlami/nvme/sparse_emb_data -name "cache-*" 2>/dev/null | wc -l
echo TH3 VERIFY DONE
