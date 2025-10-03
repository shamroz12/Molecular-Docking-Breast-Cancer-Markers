#!/usr/bin/env bash
set -euo pipefail
# Example run commands for AutoDock Vina. Edit receptor/ligand paths and box center/size.
ROOT=$(dirname "$0")
INPUTS="$ROOT/data/inputs"
RESULTS="$ROOT/data/results"
mkdir -p "$RESULTS"

# Example: for each ligand -> run vina against 3PP0 (HER2)
RECEPTOR="$INPUTS/receptors/3PP0.pdbqt"   # replace with prepared receptor PDBQT
for lig in "$INPUTS/labeled_ligands"/*.pdbqt; do
    base=$(basename "$lig" .pdbqt)
    out="$RESULTS/${base}_to_3PP0_out.pdbqt"
    log="$RESULTS/${base}_to_3PP0_log.txt"
    echo "Running vina for $base against 3PP0 (edit center/size as needed)..."
    vina --receptor "$RECEPTOR" --ligand "$lig" --out "$out" --log "$log" --center_x 10 --center_y 10 --center_z 10 --size_x 20 --size_y 20 --size_z 20 --exhaustiveness 8 || echo 'vina failed or not installed.'
done

echo "Docking script finished (or vina missing). Check $RESULTS for outputs."
