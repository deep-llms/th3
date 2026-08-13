#1 +120+a
#th3-check-stale
echo '=== any checkpoint beyond 7000? ==='
ls -d /opt/dlami/nvme/sparse_emb_outputs/residual_ant/checkpoint-* | sort -V | tail -5
echo '=== incomplete checkpoints (no trainer_state)? ==='
for d in /opt/dlami/nvme/sparse_emb_outputs/residual_ant/checkpoint-*/; do
    [ ! -f "$d/trainer_state.json" ] && echo "INCOMPLETE: $(basename $d)"
done
echo "check done"
echo '=== experiments.log ==='
cat /opt/dlami/nvme/sparse_emb_outputs/logs/experiments.log 2>/dev/null
echo '=== residual_ant.log last 5 lines ==='
tail -5 /opt/dlami/nvme/sparse_emb_outputs/logs/residual_ant.log 2>/dev/null
echo TH3 STALE CHECK DONE
