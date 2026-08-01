#1
#train-ant-ours
eval "$($HOME/miniconda3/bin/conda shell.bash hook)"
sleep 3
conda activate sparse_emb
sleep 3

nvidia-smi
sleep 3

# Clean previous outputs
rm -rf /opt/dlami/nvme/sparse_emb_outputs/ant_ours
rm -rf /opt/dlami/nvme/sparse_emb_outputs/logs

# Copy accelerate config
mkdir -p ~/.cache/huggingface/accelerate
cp resources/accelerate_config.yaml ~/.cache/huggingface/accelerate/default_config.yaml
sleep 3

export WANDB_MODE=offline
python run_experiments.py --experiments 1 --stop-at-step 10000 --log-dir /opt/dlami/nvme/sparse_emb_outputs/logs
