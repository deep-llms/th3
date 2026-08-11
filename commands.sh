#1
#th3-xling-1
eval "$($HOME/miniconda3/bin/conda shell.bash hook)"
sleep 3
conda activate eval
sleep 3

python -c "import scipy" 2>/dev/null || pip install -q scipy

O=/opt/dlami/nvme/sparse_emb_outputs
mkdir -p $O/crosslingual
CUDA_VISIBLE_DEVICES=0 python crosslingual/run_crosslingual.py \
    --checkpoints $O/ant_ours/checkpoint-10000 \
    --tests t6 t8 probe_b --mexa-sentences 500 \
    --output-dir $O/crosslingual/ant_ours \
    > $O/crosslingual/ant_ours.log 2>&1 &
CUDA_VISIBLE_DEVICES=1 python crosslingual/run_crosslingual.py \
    --checkpoints $O/baseline/checkpoint-10000 \
    --tests t6 t8 probe_b --mexa-sentences 500 \
    --output-dir $O/crosslingual/baseline \
    > $O/crosslingual/baseline.log 2>&1 &
wait

echo '=== ant_ours log tail ==='
tail -20 $O/crosslingual/ant_ours.log
echo '=== baseline log tail ==='
tail -20 $O/crosslingual/baseline.log
ls -la $O/crosslingual/*/
echo TH3 XLING DONE
