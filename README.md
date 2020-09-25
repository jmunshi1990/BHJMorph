# BHJMorph
An algorithm to convert atomic trajectories to spatially discrete morphology

# Citation 
Developed by Joydeep Munshi and Indranil Roy at Lehigh University 

1. Joydeep Munshi, Rabindra Dulal, TeYu Chien, Wei Chen, and Ganesh Balasubramanian
ACS Applied Materials & Interfaces 2019 11 (18), 17056-17067
DOI: 10.1021/acsami.9b02719

2. Joydeep Munshi, et al., Composition and processing dependent miscibility of P3HT and PCBM in organic solar cells by coarse-grained molecular simulations. Computational Materials Science, 2018. 155: p. 112-115

3. Munshi, J., Ghumman, U.F., Iyer, A., Dulal, R., Chen, W., Chien, T. and Balasubramanian, G. (2019), Effect of polydispersity on the bulk‐heterojunction morphology of P3HT:PCBM solar cells. J. Polym. Sci. Part B: Polym. Phys., 57: 895-903. doi:10.1002/polb.24854

# Desctiprtion
The codes are implemented in Matlab to read atomic trajectories from Gromacs for any nanoscale system. The main aim of the code is to find
morphological features of typical bulkheterojunction layers in organic photovoltaics device - such as - domain size, interfacial area, percolation ratio and exciton diffusion to charge transport probability.

# Features
1. READ_GRO.m - The function reads coordinates of donor material from .gro files from Gromacs simulations 

2. READ_GRO_PCBM.m - The function reads coordinates of fullerene acceptor material from .gro files from Gromacs simulations

3. READ_GRO_P3HT_backbone.m - The function reads coordinates of center-of-mass of the backbone of donor polymer from .gro files from Gromacs simulations

4. pixel_morph.m - returns a 3D matrix of binarized two-phase bulk heterojunction morphology of the photoactive layer

5. dom_size.m - calculates average domain size of donor and acceptor materials from the discretized morphology

6. interface_area.m - calculates interfacial area to volume ratio of the donor-acceptor interface from the discretized morphology

7. percolation.m - calculates average domain size of donor and acceptor materials from the discretized morphology

8. IPCEcalcScript.m - This matlab script utilizes dom_size, interface_area and percolation funcitons to calculate the overall exciton diffusion to charge transport probability - a performance metric for OPV device efficiency
