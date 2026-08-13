#1
#th3-resume-residual-ant
eval "$($HOME/miniconda3/bin/conda shell.bash hook)"
sleep 3
conda activate sparse_emb
sleep 3

nvidia-smi | head -12
python -c "import torch; assert torch.cuda.is_available(); print(f'CUDA OK: {torch.cuda.device_count()} GPUs')"

# Resume from checkpoint-7000 (no fresh-dir guard — dir must exist for resume)
if [ ! -d /opt/dlami/nvme/sparse_emb_outputs/residual_ant ]; then echo "ERROR: residual_ant dir missing, cannot resume"; exit 1; fi

mkdir -p ~/.cache/huggingface/accelerate
cp resources/accelerate_config.yaml ~/.cache/huggingface/accelerate/default_config.yaml

export WANDB_MODE=offline
python run_experiments.py --experiments 5 --stop-at-step 10000 --log-dir /opt/dlami/nvme/sparse_emb_outputs/logs
