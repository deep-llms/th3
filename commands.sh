#1
#retrain-h100-2-ant-ours-clean
eval "$($HOME/miniconda3/bin/conda shell.bash hook)"
sleep 3
conda activate sparse_emb
sleep 3

nvidia-smi
sleep 3

echo '=== state before cleanup ==='
ls -la /opt/dlami/nvme/sparse_emb_outputs/

# Old run was ALREADY moved to ant_ours_old16x by the killed relaunch — do NOT mv again
# (mv onto an existing dir would nest inside it). Verify the archive exists:
if [ ! -d /opt/dlami/nvme/sparse_emb_outputs/ant_ours_old16x ]; then echo "ERROR: ant_ours_old16x archive missing"; exit 1; fi

# baseline stays untouched — its training was correct and is the valid reference
if [ ! -d /opt/dlami/nvme/sparse_emb_outputs/baseline ]; then echo "ERROR: baseline dir missing"; exit 1; fi

# Remove PARTIAL dir left by the killed retrain (else Trainer resumes from a partial checkpoint)
rm -rf /opt/dlami/nvme/sparse_emb_outputs/ant_ours
rm -rf /opt/dlami/nvme/sparse_emb_outputs/smoke_ant

if [ -d /opt/dlami/nvme/sparse_emb_outputs/ant_ours ]; then echo "ERROR: ant_ours still exists"; exit 1; fi

# Config
mkdir -p ~/.cache/huggingface/accelerate
cp resources/accelerate_config.yaml ~/.cache/huggingface/accelerate/default_config.yaml

# Train ant_ours, stop at 10k
export WANDB_MODE=offline
python run_experiments.py --experiments 1 --stop-at-step 10000 --log-dir /opt/dlami/nvme/sparse_emb_outputs/logs
