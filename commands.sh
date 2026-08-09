#1 +120+a
#th3-verify-eval-loading
echo '=== eval_parallel progress ==='
tail -15 eval_parallel.log 2>/dev/null
echo '=== ant_ours ckpt-1000 eval.log (no progress bars) ==='
grep -avE 'it/s' /opt/dlami/nvme/sparse_emb_outputs/ant_ours/checkpoint-1000/eval.log | head -12
echo '=== train_config presence ==='
ls -la /opt/dlami/nvme/sparse_emb_outputs/ant_ours/train_config.json
echo '=== gpu ==='
nvidia-smi | grep -E "MiB /" | head -8
