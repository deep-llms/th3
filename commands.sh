#1 +120+a
#check-ant-ours-embedding
eval "$($HOME/miniconda3/bin/conda shell.bash hook)"
sleep 3
conda activate sparse_emb
sleep 3

python -c "
import torch
state = torch.load('/opt/dlami/nvme/sparse_emb_outputs/ant_ours/checkpoint-1000/embedding.pt', map_location='cpu', weights_only=True)
print('Keys:', sorted(state.keys()))
for k, v in sorted(state.items()):
    print(f'  {k}: shape={list(v.shape)}, dtype={v.dtype}')
"
