#1
#probe-fixed-eval-one-ckpt
eval "$($HOME/miniconda3/bin/conda shell.bash hook)"
sleep 3
conda activate eval
sleep 3

ls /opt/dlami/nvme/sparse_emb_outputs/ant_ours/train_config.json
ls /opt/dlami/nvme/sparse_emb_outputs/ant_ours/checkpoint-10000/train_config.json
ls /opt/dlami/nvme/sparse_emb_outputs/baseline/train_config.json

CUDA_VISIBLE_DEVICES=0 python eval/eval_checkpoint.py \
    --checkpoint /opt/dlami/nvme/sparse_emb_outputs/ant_ours/checkpoint-10000 \
    --eval-dir /opt/dlami/nvme/sparse_emb_data/Qwen_Qwen3-0.6B/eval \
    --tokenizer-name Qwen/Qwen3-0.6B \
    --bf16 \
    --ppl-only \
    --langs en
