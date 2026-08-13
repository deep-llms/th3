#1 +120+a
#th3-pre-resume-check
echo '=== residual_ant checkpoints ==='
ls -d /opt/dlami/nvme/sparse_emb_outputs/residual_ant/checkpoint-* | sort -V
echo '=== train_config.json ==='
cat /opt/dlami/nvme/sparse_emb_outputs/residual_ant/train_config.json 2>/dev/null | head -5 || echo "MISSING (check parent)"
cat /opt/dlami/nvme/sparse_emb_outputs/residual_ant/../residual_ant/train_config.json 2>/dev/null | head -5
echo '=== embedding.pt in latest checkpoint? ==='
ls -la /opt/dlami/nvme/sparse_emb_outputs/residual_ant/checkpoint-7000/embedding.pt 2>/dev/null || echo "MISSING"
echo '=== trainer_state in latest checkpoint? ==='
ls -la /opt/dlami/nvme/sparse_emb_outputs/residual_ant/checkpoint-7000/trainer_state.json 2>/dev/null || echo "MISSING"
echo '=== any incomplete checkpoint dirs (no trainer_state)? ==='
for d in /opt/dlami/nvme/sparse_emb_outputs/residual_ant/checkpoint-*/; do
    if [ ! -f "$d/trainer_state.json" ]; then
        echo "INCOMPLETE: $(basename $d)"
    fi
done
echo '=== logs dir ==='
ls -la /opt/dlami/nvme/sparse_emb_outputs/logs/residual_ant.log 2>/dev/null
ls -la /opt/dlami/nvme/sparse_emb_outputs/logs/experiments.log 2>/dev/null
echo '=== gpu free? ==='
nvidia-smi | grep -E "No running"
echo TH3 PRE-RESUME DONE
