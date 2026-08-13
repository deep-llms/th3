#1 +120+a
#th3-find-crash
echo '=== all run logs from Aug 13 ==='
ls -la _run_log_/_run-2026-08-13* 2>/dev/null || echo "none"
echo '=== any residual_ant run log? ==='
ls -la _run_log_/*residual* 2>/dev/null || echo "none"
echo '=== last 3 run logs content (tail 50 each) ==='
for f in $(ls -t _run_log_/*.log 2>/dev/null | head -3); do
    echo "--- $f ---"
    tail -50 "$f"
done
echo '=== dmesg GPU errors? ==='
dmesg | grep -iE "gpu|nccl|xid|error|oom|killed" | tail -10 || echo "none"
echo '=== residual_ant dir ==='
ls -la /opt/dlami/nvme/sparse_emb_outputs/residual_ant/ 2>/dev/null || echo "NOT EXIST"
echo '=== experiments.log ==='
cat /opt/dlami/nvme/sparse_emb_outputs/logs/experiments.log 2>/dev/null || echo "empty"
echo TH3 CRASH CHECK DONE
