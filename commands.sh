#1
#th3-ppl-bytoken-and-freq
eval "$($HOME/miniconda3/bin/conda shell.bash hook)"
sleep 3
conda activate eval
sleep 3

nvidia-smi | head -12

O=/opt/dlami/nvme/sparse_emb_outputs
CUDA_VISIBLE_DEVICES=0 python eval/ppl_bytoken.py \
    --checkpoint $O/ant_ours/checkpoint-10000 \
    --eval-dir /opt/dlami/nvme/sparse_emb_data/Qwen_Qwen3-0.6B/eval \
    --tokenizer-name Qwen/Qwen3-0.6B --bf16 \
    > $O/ant_ours/checkpoint-10000/ppl_bytoken.log 2>&1 &
CUDA_VISIBLE_DEVICES=1 python eval/ppl_bytoken.py \
    --checkpoint $O/baseline/checkpoint-10000 \
    --eval-dir /opt/dlami/nvme/sparse_emb_data/Qwen_Qwen3-0.6B/eval \
    --tokenizer-name Qwen/Qwen3-0.6B --bf16 \
    > $O/baseline/checkpoint-10000/ppl_bytoken.log 2>&1 &
python scripts/count_token_freq.py \
    --data-dir /opt/dlami/nvme/sparse_emb_data/Qwen_Qwen3-0.6B/train \
    --tokenizer-name Qwen/Qwen3-0.6B \
    --sample-every 10 --num-workers 64 \
    --output $O/token_freq.npz \
    > $O/token_freq.log 2>&1 &
wait

echo '=== ant_ours summary ==='
cat $O/ant_ours/checkpoint-10000/eval_ppl_bytoken_summary.json
echo '=== baseline summary ==='
cat $O/baseline/checkpoint-10000/eval_ppl_bytoken_summary.json
echo '=== freq log tail ==='
tail -8 $O/token_freq.log
echo TH3 BYTOKEN DONE
