# LatinHypercubeSampler

LHSampling.m is capable of generating an n-level p-dimensional latin hypercube sample for design of numerical experiments. Unlike MATLAB's standard lhdesign, this function has the capability of placing samples in proximity of vertices and similar logic can be extended to apply other constraints to the LHDesign. 

The overall schematic is as follows 
1. pick 2^p-points randomly, but in the proximity of each vertex in p-dimensional space 
2. pick (n-2^p) points randomly in the remaining subspace 
3. check uniformity of design matrix and optimize until distance metric is minimized 
