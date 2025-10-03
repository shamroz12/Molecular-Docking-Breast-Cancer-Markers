# Molecular Docking — Real Data Bundle (HER2 + BRCA1)

This bundle provides scripts and metadata to fetch real PDB structures (HER2: 3PP0, BRCA1: 1JNX),
retrieve example ligands (Lapatinib and Bractoppin), prepare docking inputs, and run AutoDock Vina.

**Important:** This archive *does not* include large binary files (PDB/SDF/PDBQT) due to environment restrictions.
Instead, it contains *automated scripts* that will download the real data to your machine and prepare it.

## What's included
- `download_data.py` — downloads PDB files (3PP0, 1JNX) and fetches ligand SMILES from PubChem / literature sources.
- `ligands.csv` — list of chosen ligands and SMILES (Lapatinib, Bractoppin).
- `prepare.sh` — convenience shell script (uses OpenBabel / obabel and vina) to convert and prepare files.
- `run_docking.sh` — example docking commands calling AutoDock Vina (assumes `vina` is installed).
- `pymol_visualize.py` — PyMOL script to render binding poses (run inside PyMOL).
- `RESULTS_TEMPLATE.md` — template for recording docking scores and observations.
- `LICENSE` (MIT)

## Quick usage (on your computer)
1. Ensure you have: Python 3.8+, `curl` or `requests`, OpenBabel (`obabel`), AutoDock Vina, PyMOL (for images).
2. Create a conda env or ensure system has these tools installed.
3. Run `python3 download_data.py` — this will create `data/receptors/` and `data/ligands/` with downloaded PDB/SMILES.
4. Convert SMILES to 3D SDF/PDBQT (example using OpenBabel in `prepare.sh`), or use RDKit to generate 3D conformers.
5. Run `bash run_docking.sh` to perform docking (edit grid centers/sizes as appropriate).
6. Visualize results in PyMOL: `pymol -cq pymol_visualize.py -- data/results/your_out.pdbqt`

## Notes & provenance
- HER2 PDB: **3PP0** — source: RCSB PDB.
- BRCA1 PDB: **1JNX** — source: RCSB PDB.
- Lapatinib — PubChem CID 208908 (EGFR/ERBB2 inhibitor).
- Bractoppin — BRCA1 tBRCT inhibitor (Periasamy et al., Cell Chem Biol. 2018). SMILES provided in `ligands.csv`.

If you want, I can also attempt to run the docking steps here — but my environment can't run AutoDock Vina or PyMOL. The scripts are ready for you or a compute server.
