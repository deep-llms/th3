#1
#th3-train-ant-ours
eval "$($HOME/miniconda3/bin/conda shell.bash hook)"
sleep 3
conda activate sparse_emb
sleep 3

nvidia-smi
sleep 3

# Verify CUDA
python -c "import torch; assert torch.cuda.is_available(), 'CUDA FAILED'; print(f'CUDA OK: {torch.cuda.device_count()} GPUs')"
sleep 5

# Verify output dir not exist (fresh start); baseline must be untouched
if [ -d /opt/dlami/nvme/sparse_emb_outputs/ant_ours ]; then echo "ERROR: ant_ours dir already exists"; exit 1; fi
if [ ! -d /opt/dlami/nvme/sparse_emb_outputs/baseline ]; then echo "ERROR: baseline dir missing"; exit 1; fi

# Config
mkdir -p ~/.cache/huggingface/accelerate
cp resources/accelerate_config.yaml ~/.cache/huggingface/accelerate/default_config.yaml

# Train ant_ours (entmax). Full-data schedule (~34.5k steps), stopped manually at 10k.
export WANDB_MODE=offline
python run_experiments.py --experiments 1 --stop-at-step 10000 --log-dir /opt/dlami/nvme/sparse_emb_outputs/logs
