#!/usr/bin/env python3
"""Download real data: PDB files for HER2 (3PP0) and BRCA1 (1JNX) and write ligand SMILES to files.
Requires internet connection. Run: python3 download_data.py
"""
import os, requests, csv, sys, pathlib

BASE = pathlib.Path(__file__).parent.resolve()
data_dir = BASE / 'data'
receptors_dir = data_dir / 'receptors'
ligands_dir = data_dir / 'ligands'
receptors_dir.mkdir(parents=True, exist_ok=True)
ligands_dir.mkdir(parents=True, exist_ok=True)

pdbs = {'3PP0':'https://files.rcsb.org/download/3PP0.pdb', '1JNX':'https://files.rcsb.org/download/1JNX.pdb'}
for pid, url in pdbs.items():
    out = receptors_dir / f"{pid}.pdb"
    if out.exists():
        print(f"{out} already exists, skipping.")
        continue
    print(f"Downloading {pid} from {url} ...")
    r = requests.get(url, timeout=30)
    if r.status_code == 200 and r.text.strip():
        out.write_text(r.text)
        print(f"Wrote {out}")
    else:
        print(f"Failed to download {pid}: status {r.status_code}", file=sys.stderr)

# Ligands: read ligands.csv and write SMILES files
lig_csv = BASE / 'ligands.csv'
with open(lig_csv) as fh:
    reader = csv.DictReader(fh)
    for row in reader:
        name = row['name']
        smiles = row['smiles']
        out = ligands_dir / f"{name}.smi"
        out.write_text(smiles + '\n')
        print(f"Wrote SMILES for {name} -> {out}")

print('\nDownload step complete. Next, run the preparation script (prepare.sh) to convert SMILES to 3D SDF/PDBQT using OpenBabel or RDKit.')
