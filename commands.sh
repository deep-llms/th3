#1 +120+a
#grep-loaded-line-and-probe-result
echo '=== A. grep OLD eval.log files for "Loaded compositional model" (expect count 0 in every file) ==='
for f in /opt/dlami/nvme/sparse_emb_outputs/ant_ours/checkpoint-*/eval.log /opt/dlami/nvme/sparse_emb_outputs/baseline/checkpoint-*/eval.log; do
    echo "$f: $(grep -c 'Loaded compositional model' "$f")"
done

echo '=== B. probe result: fresh eval_ppl.json written by FIXED eval ==='
cat /opt/dlami/nvme/sparse_emb_outputs/ant_ours/checkpoint-10000/eval_ppl.json

echo ''
echo '=== C. probe run log: loading lines ==='
PLOG=$(ls -t $HOME/deep-llms_th3/_run_log_/*probe-fixed-eval-one-ckpt* 2>/dev/null | head -1)
if [ -z "$PLOG" ]; then
    PLOG=$(find "$HOME" -maxdepth 4 -name "*probe-fixed-eval-one-ckpt*" 2>/dev/null | head -1)
fi
echo "probe log: $PLOG"
grep -E "train_config|Loaded compositional|inferred|No such file|ppl=|loss=" "$PLOG" | head -20
