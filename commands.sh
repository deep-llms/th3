#1 +60+a
#th3-cancel-clean-shared-local-tied
echo '=== th3 cancel shared-local tied ==='
date -u
hostname

for TASK_SIGNAL in TERM TERM KILL; do
    pkill -"$TASK_SIGNAL" -f '[t]rain_compositional.py' 2>/dev/null || true
    pkill -"$TASK_SIGNAL" -f '[a]ccelerate launch' 2>/dev/null || true
    sleep 5
done

nvidia-smi --query-compute-apps=pid --format=csv,noheader \
    | sed '/^[[:space:]]*$/d' \
    | sort -u \
    | while read -r TASK_PID; do
        kill -9 "$TASK_PID" 2>/dev/null && echo "killed remaining GPU pid $TASK_PID" || true
      done
sleep 5

echo '=== remove only current shared-local tied artifacts ==='
rm -rf -- /opt/dlami/nvme/sparse_emb_outputs/shared_local_tied
rm -rf -- /home/ubuntu/deep-llms_th3/wandb/offline-run-20260816_092721-y29fc7yj

echo '=== verify th3 clean ==='
pgrep -af '[t]rain_compositional.py|[a]ccelerate launch' || echo 'training processes: none'
TASK_GPU_PROCESSES="$(nvidia-smi --query-compute-apps=pid --format=csv,noheader | sed '/^[[:space:]]*$/d')"
if [ -n "$TASK_GPU_PROCESSES" ]; then
    echo "ERROR: GPU processes remain:"
    nvidia-smi --query-compute-apps=gpu_uuid,pid,process_name,used_memory --format=csv,noheader
    exit 1
fi
echo 'GPU processes: none'
test ! -e /opt/dlami/nvme/sparse_emb_outputs/shared_local_tied
test ! -e /home/ubuntu/deep-llms_th3/wandb/offline-run-20260816_092721-y29fc7yj
echo 'shared_local_tied output: gone'
echo 'shared_local_tied W&B run: gone'
echo 'TH3 CLEAN'
