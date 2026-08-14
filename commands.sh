#1 +120+a
#th3-finetune-progress
echo '=== GPU ==='
nvidia-smi | grep -E "MiB /|python" | head -4
echo '=== finetune output dir ==='
ls /opt/dlami/nvme/sparse_emb_outputs/finetune/*.json 2>/dev/null | head -10 || echo "no results yet"
echo '=== latest run log from _run_log_ ==='
f=$(ls -t _run_log_/*finetune*.log 2>/dev/null | head -1)
[ -n "$f" ] && tail -30 "$f" || echo "no finetune run log"
echo TH3 PROGRESS
