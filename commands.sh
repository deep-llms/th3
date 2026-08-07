#1 +120+a
#verify-smoke-and-move-old-dirs
echo '=== A. smoke run log: loss lines + config check ==='
SLOG=$(ls -t $HOME/deep-llms_th3/_run_log_/*smoke-ant-fixed* 2>/dev/null | head -1)
if [ -z "$SLOG" ]; then
    SLOG=$(find "$HOME" -maxdepth 4 -name "*smoke-ant-fixed*" 2>/dev/null | head -1)
fi
echo "smoke log: $SLOG"
grep -E "'loss':|train_config|compositional section|SMOKE CHECKS" "$SLOG" | head -12

echo ''
echo '=== B. move old (16x-gradient) output dir — baseline stays, its training was correct ==='
mv -v /opt/dlami/nvme/sparse_emb_outputs/ant_ours /opt/dlami/nvme/sparse_emb_outputs/ant_ours_old16x

echo ''
echo '=== C. resulting layout ==='
ls -la /opt/dlami/nvme/sparse_emb_outputs/
