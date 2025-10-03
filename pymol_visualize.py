# PyMOL batch script to load receptor + ligand pose and save a PNG image.
# Usage: pymol -cq pymol_visualize.py -- data/results/ligand_out.pdbqt
import sys, pathlib
from pymol import cmd

def render(pose_path, out_png='binding_pose.png'):
    cmd.reinitialize()
    cmd.load(str(pose_path), 'pose')
    # If receptor is present as HETATM/chain in same file, split; else load receptor separately.
    cmd.hide('everything')
    cmd.show('cartoon', 'pose and polymer')
    cmd.show('sticks', 'pose and not polymer')
    cmd.bg_color('white')
    cmd.png(out_png, dpi=300, ray=1)
    print('Saved', out_png)

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print('Provide path to pose PDBQT (e.g. data/results/ligand_out.pdbqt)')
        sys.exit(1)
    pose = pathlib.Path(sys.argv[1])
    render(pose, out_png=str(pose.with_suffix('.png')))
