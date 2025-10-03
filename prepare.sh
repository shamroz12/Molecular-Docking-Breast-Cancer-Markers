#!/usr/bin/env bash
set -euo pipefail
# Example preparation steps (requires OpenBabel (obabel) and optionally MGLTools or vina tools).
# Converts SMILES to 3D SDF and then to PDBQT (if obabel/vina tools available).
ROOT=$(dirname "$0")
DATA="$ROOT/data"
LIG_DIR="$DATA/ligands"
REC_DIR="$DATA/receptors"
OUT_DIR="$DATA/inputs"
mkdir -p "$OUT_DIR/labeled_ligands" "$OUT_DIR/receptors"

echo "Converting SMILES to 3D SDF using OpenBabel (obabel)..."
for smi in "$LIG_DIR"/*.smi; do
    name=$(basename "$smi" .smi)
    echo "Processing $name"
    # 1) generate 3D SDF
    if command -v obabel >/dev/null 2>&1; then
        obabel -ismi "$smi" -osdf -O "$OUT_DIR/labeled_ligands/${name}.sdf" --gen3D
    else
        echo "obabel not found; please install OpenBabel or convert SMILES with RDKit."
    fi
done

# Example receptor preparation: strip ligands/waters if needed. This uses sed as placeholder.
for pdb in "$REC_DIR"/*.pdb; do
    base=$(basename "$pdb" .pdb)
    cp "$pdb" "$OUT_DIR/receptors/${base}.pdb"
    echo "(You should further prepare ${base}.pdb: remove heteroatoms, add hydrogens, and convert to PDBQT.)"
done

echo "Preparation complete. Use AutoDockTools or MGLTools prepare_receptor4.py and prepare_ligand4.py to make PDBQT files."
