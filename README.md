# ttlg_dos - Density of States Calculation of Twisted Trilayer Graphene

Calculation of the electronic band structure and density of twisted trilayer graphene with two independent twist angles using a low-energy momentum space continuum model. All scripts are in MATLAB. All files are identical to the [original package](https://github.com/ziyanzzhu/ttlg), this cloned repository is tweaked to generate data for the present paper. `/data_gen/` folder contains final data used for this work and instructions to generate it. 

## Citation

For reference of the `ttlg_dos` model, please see and cite the following manuscript: 

"Twisted Trilayer Graphene: a precisely tunable platform for correlated electrons" 

Ziyan Zhu, Stephen Carr, Daniel Massatt, Mitchell Luskin, and Efthimios Kaxiras

Phys. Rev. Lett. 125, 116404



## Contact

Developer - Ziyan (Zoe) Zhu: ziyanzhu@stanford.edu

Data generation - Mohammad Babar : mdbabar@umich.edu


## Code Descriptions

1. `getRecip.m`: calculates the reciprocal space lattice

2. `Layer.m`: creates an object that contains the geometry of 3 monolayers

3. `kDOF_tri.m`: creates the k degrees of freedom for a given cutoff

4. `gen_interlayer_terms.m`: constructs interlayer Hamiltonian (Koshino et al. 2017 style with w_aa \neq w_ab)

5. `gen_intralayer_terms_dirac.m`: constracts intralayer rotated Dirac Hamiltonian 

6. `dos_gauss_smear.m`: calculates the DOS using Gaussian smaering

7. `dos_calc_tri.m`: calculates the ttlg DOS and (optional) save data to folder `/sweep/`

8. `/geom/` folder contains scripts to calculate the moire of moire lengths and to make Figure 1 of the [original paper](https://journals.aps.org/prl/pdf/10.1103/PhysRevLett.125.116404).  

9. `/data_gen/` folder contains final data used for this work. For high resolution data, we used the following parameters (see next section Default Parameters to compare),

i.  `k_cutoff = 7` : High momentum cutoff radius 

ii. `param = 6e-3` : Gaussian smoothing

iii. `nq = 22 x 22` : Grid size (Default)

iv. `num_eigs > 200` : Large number of bands in DOS

v. `E_list = linspace(-1,1,1e3)` : Energy range -1 to 1eV

These parameters require high memory and cores for calculation, for which we used the [PSC Bridges2 supercomputer](https://www.psc.edu/resources/bridges-2/). We requested 56 cores from each node, and dispatched multiple runs (`/data_gen/call_dos*.m`) specifying different twist angle combinations. All DOS files are saved in `/data_gen/sweep/` containing all twist angles from 1-5 degrees for layers L12 and L23. 


Description of input arguments can be found at the beginning of each file. 


## Default Parameters

Examples can be found in the [original repository](https://github.com/ziyanzzhu/ttlg). 

Default parameters in input files are as follows,
`call_dos.m`: calculates the DOS by calling dos_calc_tri.m for θ12 = 1 deg., θ23 = 1 deg. keeping `nq = 21` and `num_eigs = 40`.

Outputs will be saved to folder `/data`; default number of parallel workers 4. Parallelize the k-space sampling. Have the option to run on a cluster. 

The DOS is obtained by integrating over the bilayer moir\'e Brillouin zone of L1 and L2 only.  Need to also integrate over the L2 and L3 DOS and overage over the two moir\'e Brillouin zones. `k_cutoff` is set to be 3 (in new version `k_cutoff = 4`), resulting in ~1,800 degrees of freedom, and the grid size is 22 x 22 (`(nq+1) x (nq+1)`). For a more accurate result, need to increase the cutoff radius and adjust the grid sampling. The variable `param` is the Gaussian full-width-half-maximum in eV and needs to be adjusted accordingly. In this example, we set `param = 8e-3`.

