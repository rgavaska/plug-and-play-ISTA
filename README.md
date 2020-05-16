
### Plug-and-play ISTA

This is a Matlab implementation of the NLM-based PnP-ISTA algorithm used in the following paper:

R. G. Gavaskar and K. N. Chaudhury, "Plug-and-Play ISTA Converges With Kernel Denoisers," IEEE Signal Processing Letters, vol. 27, pp. 610-614, 2020.

[[Paper]](https://ieeexplore.ieee.org/document/9064581)
[[Arxiv]](https://arxiv.org/abs/2004.03145)

The code here was used to produce the results reported in the paper.

### Usage
Run the file 'demo_inpainting.m' to run a demo of image inpainting using PnP-ISTA.

The main PnP-ISTA algorithm is implemented in 'pnpISTA.m'.

Tested on Matlab 9.6.0 (R2019a).

### Credits
The code 'utils/nanmedfilt2.m' has been downloaded from: [https://www.mathworks.com/matlabcentral/fileexchange/41457-nanmedfilt2].


