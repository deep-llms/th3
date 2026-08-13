#1
#th3-resume-residual-ant-clean
eval "$($HOME/miniconda3/bin/conda shell.bash hook)"
sleep 3
conda activate sparse_emb
sleep 3

# Clean stale logs from the CUDA-crashed resume attempt
rm -f /opt/dlami/nvme/sparse_emb_outputs/logs/experiments.log
echo "cleaned stale experiments.log"

nvidia-smi | head -12
python -c "import torch; assert torch.cuda.is_available(); print(f'CUDA OK: {torch.cuda.device_count()} GPUs')"

if [ ! -d /opt/dlami/nvme/sparse_emb_outputs/residual_ant ]; then echo "ERROR: residual_ant dir missing"; exit 1; fi

mkdir -p ~/.cache/huggingface/accelerate
cp resources/accelerate_config.yaml ~/.cache/huggingface/accelerate/default_config.yaml

export WANDB_MODE=offline
python run_experiments.py --experiments 5 --stop-at-step 10000 --log-dir /opt/dlami/nvme/sparse_emb_outputs/logs
