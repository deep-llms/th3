#1
#retrain-h100-2-ant-ours
eval "$($HOME/miniconda3/bin/conda shell.bash hook)"
sleep 3
conda activate sparse_emb
sleep 3

nvidia-smi
sleep 3

# Move old 16x-gradient run aside (baseline stays — its training was correct), clean smoke leftovers
mv -v /opt/dlami/nvme/sparse_emb_outputs/ant_ours /opt/dlami/nvme/sparse_emb_outputs/ant_ours_old16x
rm -rf /opt/dlami/nvme/sparse_emb_outputs/smoke_ant

# Guard: fresh output dir (else Trainer would resume from old checkpoints)
if [ -d /opt/dlami/nvme/sparse_emb_outputs/ant_ours ]; then echo "ERROR: ant_ours dir still exists"; exit 1; fi

# Config
mkdir -p ~/.cache/huggingface/accelerate
cp resources/accelerate_config.yaml ~/.cache/huggingface/accelerate/default_config.yaml

# Train ant_ours, stop at 10k
export WANDB_MODE=offline
python run_experiments.py --experiments 1 --stop-at-step 10000 --log-dir /opt/dlami/nvme/sparse_emb_outputs/logs
