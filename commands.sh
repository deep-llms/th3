#1
#th3-finetune-battery
eval "$($HOME/miniconda3/bin/conda shell.bash hook)"
sleep 3
conda activate sparse_emb
sleep 3

nvidia-smi | head -12

python finetune/run_all.py \
    --checkpoints \
        residual_ant=/opt/dlami/nvme/sparse_emb_outputs/residual_ant/checkpoint-10000 \
        ant_ours=/opt/dlami/nvme/sparse_emb_outputs/ant_ours/checkpoint-10000 \
        baseline=/opt/dlami/nvme/sparse_emb_outputs/baseline/checkpoint-10000 \
    --tasks ag_news sst2 xnli paws_x hellaswag \
    --modes full probe \
    --seeds 42 123 456 \
    --output-dir /opt/dlami/nvme/sparse_emb_outputs/finetune \
    --device cuda
