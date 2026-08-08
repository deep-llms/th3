#1 +120+a
#th3-clean-prep-retry
echo '=== 1. kill any training (safety) ==='
for i in 1 2 3; do
    echo "attempt $i"
    pkill -f run_experiments.py 2>/dev/null
    pkill -f train_original_ant.py 2>/dev/null
    pkill -f train_compositional.py 2>/dev/null
    pkill -f "accelerate launch" 2>/dev/null
    sleep 5
done

echo '=== 2. state before cleanup ==='
ls -la /opt/dlami/nvme/sparse_emb_outputs/

echo '=== 3. delete old run output folders on th3 (baseline KEPT) ==='
if [ ! -d /opt/dlami/nvme/sparse_emb_outputs/baseline ]; then echo "ERROR: baseline dir missing"; exit 1; fi
rm -rf /opt/dlami/nvme/sparse_emb_outputs/ant_ours
rm -rf /opt/dlami/nvme/sparse_emb_outputs/ant_ours_old16x
rm -rf /opt/dlami/nvme/sparse_emb_outputs/smoke_ant
rm -rf /opt/dlami/nvme/sparse_emb_outputs/logs

echo '=== 4. remove all caches (again, harmless) ==='
rm -rf ~/.cache/huggingface/datasets
find /opt/dlami/nvme/sparse_emb_data -name "cache-*" -delete 2>/dev/null
find /opt/dlami/nvme/sparse_emb_data -name "tmp*" -delete 2>/dev/null
echo "caches removed"

echo '=== 5. GPUs empty? ==='
nvidia-smi

echo '=== 6. accelerate config ==='
mkdir -p ~/.cache/huggingface/accelerate
cp resources/accelerate_config.yaml ~/.cache/huggingface/accelerate/default_config.yaml
echo "config copied"

echo '=== 7. final state (expect ONLY baseline) ==='
ls -la /opt/dlami/nvme/sparse_emb_outputs/
echo "TH3 PREP DONE"
