#1 +120+a
#th3-probe-anchor-results
O=/opt/dlami/nvme/sparse_emb_outputs
pgrep -af analyze_anchor || echo "no analysis process"
ls -la $O/ant_ours/checkpoint-10000/anchor_usage* 2>/dev/null || echo "no outputs yet"
echo '=== ant_ours json ==='
cat $O/ant_ours/checkpoint-10000/anchor_usage.json 2>/dev/null
