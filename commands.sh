#1
#th3-eval-round2
eval "$($HOME/miniconda3/bin/conda shell.bash hook)"
sleep 3
conda activate eval
sleep 3

nvidia-smi
sleep 3

python eval/eval_parallel.py \
    --checkpoints \
        /opt/dlami/nvme/sparse_emb_outputs/ant_ours/checkpoint-1000 \
        /opt/dlami/nvme/sparse_emb_outputs/ant_ours/checkpoint-2000 \
        /opt/dlami/nvme/sparse_emb_outputs/ant_ours/checkpoint-3000 \
        /opt/dlami/nvme/sparse_emb_outputs/ant_ours/checkpoint-4000 \
        /opt/dlami/nvme/sparse_emb_outputs/ant_ours/checkpoint-5000 \
        /opt/dlami/nvme/sparse_emb_outputs/ant_ours/checkpoint-6000 \
        /opt/dlami/nvme/sparse_emb_outputs/ant_ours/checkpoint-7000 \
        /opt/dlami/nvme/sparse_emb_outputs/ant_ours/checkpoint-8000 \
        /opt/dlami/nvme/sparse_emb_outputs/ant_ours/checkpoint-9000 \
        /opt/dlami/nvme/sparse_emb_outputs/ant_ours/checkpoint-10000 \
    --eval-dir /opt/dlami/nvme/sparse_emb_data/Qwen_Qwen3-0.6B/eval \
    --tokenizer-name Qwen/Qwen3-0.6B \
    --bf16 \
    --num-gpus 8
