#1 +120+a
#debug-ant-ours-ckpt
eval "$($HOME/miniconda3/bin/conda shell.bash hook)"
sleep 3
conda activate sparse_emb
sleep 3

echo '=== ant_ours root files ==='
ls -la /opt/dlami/nvme/sparse_emb_outputs/ant_ours/ | grep -v '^d'
echo '=== ckpt-10000 files ==='
ls -la /opt/dlami/nvme/sparse_emb_outputs/ant_ours/checkpoint-10000/
echo '=== ckpt-250 files ==='
ls -la /opt/dlami/nvme/sparse_emb_outputs/ant_ours/checkpoint-250/
echo '=== md5 trainer_state ==='
md5sum /opt/dlami/nvme/sparse_emb_outputs/ant_ours/checkpoint-10000/trainer_state.json
echo '=== trainer_state first entry keys ==='
python -c "
import json
s = json.load(open('/opt/dlami/nvme/sparse_emb_outputs/ant_ours/checkpoint-10000/trainer_state.json'))
e = s['log_history'][0]
print(sorted(e.keys()))
print('step:', e.get('step'), 'loss:', e.get('loss'), 'avg_nnz:', e.get('avg_nnz'))
"
echo '=== embedding.pt keys ckpt-10000 ==='
python -c "
import torch
st = torch.load('/opt/dlami/nvme/sparse_emb_outputs/ant_ours/checkpoint-10000/embedding.pt', map_location='cpu', weights_only=True)
print([(k, list(v.shape)) for k, v in sorted(st.items())])
"
echo '=== eval.log head (what eval loaded) ==='
head -25 /opt/dlami/nvme/sparse_emb_outputs/ant_ours/checkpoint-10000/eval.log
