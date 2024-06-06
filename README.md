# Dual-modality-ghost-diffraction

Pytorch implementation of paper: Dual-Modality Ghost Diffraction in a Complex Disordered Environment

# Requirements: 

> Anaconda 3; Python 3.8.13; Pytorch 1.7.0; MATLAB

# How to use:

Step 1: Run './transmission/Image_encoding.ipynb' to encode an image information into a series of amplitude-only patterns.

Step 2: Conduct experiments to record a series of total-light intensites.

Step 3: Run './transmission/image_dynamic.mat' to retrive transmitted data in a dynamic complex disordered environment.

Step 4: Run './imaging/GI_reconstruction_dynamic.mat' to reconstruct an object in a dynamic complex disordered environment.

Step 5:Run './imaging/Reconstruction_improvement.ipynb' to enhance the reconstruction quality.
