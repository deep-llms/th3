#1 +120+a
#th3-probe-xling
O=/opt/dlami/nvme/sparse_emb_outputs
pgrep -af run_crosslingual || echo "no xling processes"
ls -la $O/crosslingual/ $O/crosslingual/*/ 2>/dev/null
echo '=== ant_ours log tail ==='
tail -c 1200 $O/crosslingual/ant_ours.log 2>/dev/null
echo '=== baseline log tail ==='
tail -c 1200 $O/crosslingual/baseline.log 2>/dev/null
