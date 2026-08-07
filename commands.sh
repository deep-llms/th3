#1 +120+a
#print-ant-ours-loss-curve
eval "$($HOME/miniconda3/bin/conda shell.bash hook)"
sleep 3
conda activate sparse_emb
sleep 3

python -c "
import json
s = json.load(open('/opt/dlami/nvme/sparse_emb_outputs/ant_ours/checkpoint-10000/trainer_state.json'))
print('keys:', sorted(s['log_history'][0].keys()))
for e in s['log_history']:
    step = e.get('step', 0)
    if 'loss' in e and (step % 200 == 0 or step <= 50):
        print(f\"step {step:>6}  loss {e['loss']:>10.4f}  nnz {e.get('avg_nnz', -1):>8.1f}  dead {e.get('dead_rate', -1):>7.4f}  ent {e.get('entropy', -1):>6.3f}\")
"
