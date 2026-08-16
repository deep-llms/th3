#1 +60+a
#th3-stop-shared-local-tied-keep-10k-scoped
echo '=== th3 stop only shared-local tied; preserve all artifacts ==='
date -u
hostname

TASK_OUTPUT_DIR=/opt/dlami/nvme/sparse_emb_outputs/shared_local_tied
TASK_PATTERN='[t]rain_compositional.py.*sparse_emb_outputs/shared_local_tied'

echo '=== matching processes before stop ==='
pgrep -af "$TASK_PATTERN" || true

pgrep -f "$TASK_PATTERN" \
    | while read -r TASK_PID; do
        kill -TERM "$TASK_PID" 2>/dev/null && echo "sent TERM to shared-local tied pid $TASK_PID" || true
      done
sleep 10

pgrep -f "$TASK_PATTERN" \
    | while read -r TASK_PID; do
        kill -KILL "$TASK_PID" 2>/dev/null && echo "sent KILL to remaining shared-local tied pid $TASK_PID" || true
      done
sleep 5

echo '=== verify stopped and checkpoint-10000 preserved ==='
if pgrep -af "$TASK_PATTERN"; then
    echo 'ERROR: shared-local tied training processes remain'
    exit 1
fi
nvidia-smi --query-compute-apps=gpu_uuid,pid,process_name,used_memory --format=csv,noheader || true

TASK_CHECKPOINT_DIR="$TASK_OUTPUT_DIR/checkpoint-10000"
test -d "$TASK_OUTPUT_DIR"
test -d "$TASK_CHECKPOINT_DIR"
test -f "$TASK_CHECKPOINT_DIR/trainer_state.json"
test -f "$TASK_CHECKPOINT_DIR/embedding.pt"
echo 'shared-local tied training processes: none'
echo 'checkpoint-10000: preserved and complete'
echo "latest checkpoint: $(find "$TASK_OUTPUT_DIR" -maxdepth 1 -type d -name 'checkpoint-*' -printf '%f\n' | sort -V | tail -1)"
echo 'outputs, caches, and W&B logs: preserved'
echo 'TH3 STOPPED'
