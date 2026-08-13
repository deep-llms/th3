#1 +120+a
#th3-debug-train
echo '=== gpu ==='
nvidia-smi | grep -E "MiB /|No running"
echo '=== processes ==='
pgrep -af "python|accelerate|train|run_experiments" | grep -v pgrep | head -10 || echo "no processes"
echo '=== experiments.log ==='
cat /opt/dlami/nvme/sparse_emb_outputs/logs/experiments.log 2>/dev/null
echo '=== residual_ant output dir ==='
ls -la /opt/dlami/nvme/sparse_emb_outputs/residual_ant/ 2>/dev/null || echo "NOT EXIST"
echo '=== residual_ant log ==='
cat /opt/dlami/nvme/sparse_emb_outputs/logs/residual_ant.log 2>/dev/null || echo "no residual_ant.log"
echo '=== run log (last 80 lines) ==='
ls -t _run_log_/*.log 2>/dev/null | head -1 | xargs tail -80 2>/dev/null || echo "no run logs"
echo '=== _RUN_STATUS_.log tail ==='
tail -5 _RUN_STATUS_.log 2>/dev/null
echo TH3 DEBUG DONE
