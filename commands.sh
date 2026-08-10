#1 +120+a
#th3-baseline-results-dump
for i in 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000; do
  for kind in eval_ppl eval_benchmarks; do
    f=/opt/dlami/nvme/sparse_emb_outputs/baseline/checkpoint-$i/$kind.json
    echo "===JSON baseline $i $kind==="
    cat "$f" 2>/dev/null || echo MISSING
    echo
  done
done
echo '=== md5s for integrity ==='
md5sum /opt/dlami/nvme/sparse_emb_outputs/baseline/checkpoint-*/eval_*.json
