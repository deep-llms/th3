#1
#th3-anchor-usage-2
eval "$($HOME/miniconda3/bin/conda shell.bash hook)"
sleep 3
conda activate eval
sleep 3

O=/opt/dlami/nvme/sparse_emb_outputs
echo '===== ant_ours (static, exact over vocab, freq-weighted) ====='
python scripts/analyze_anchor_usage.py \
    --checkpoint $O/ant_ours/checkpoint-10000 \
    --freq-npz resources/token_freq_sample10.npz \
    --output-prefix $O/ant_ours/checkpoint-10000/anchor_usage
echo TH3 ANCHOR DONE
