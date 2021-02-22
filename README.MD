# PRS-Net: Planar Reflective Symmetry Detection Net for 3D Models

## Goal

Propose a deep learning network to detect planar reflective symmetry of 3D shapes.

## Abstract

In geometry processing, symmetry is a universal type of high-level structural information of 3D models and benefits many geometry processing tasks including shape segmentation, alignment, matching, and completion. Thus it is an important problem to analyze various symmetry forms of 3D shapes. Planar reflective symmetry is the most fundamental one. Traditional methods based on spatial sampling can be time-consuming and may not be able to identify all the symmetry planes. In this paper, we present a novel learning framework to automatically discover global planar reflective symmetry of a 3D shape. Our framework trains an unsupervised 3D convolutional neural network to extract global model features and then outputs possible global symmetry parameters, where input shapes are represented using voxels. We introduce a dedicated symmetry distance loss along with a regularization loss to avoid generating duplicated symmetry planes. Our network can also identify generalized cylinders by predicting their rotation axes. We further provide a method to remove invalid and duplicated planes and axes. We demonstrate that our method is able to produce reliable and accurate results. Our neural network based method is hundreds of times faster than the state-of-the-art methods, which are based on sampling. Our method is also robust even with noisy or incomplete input surfaces.

## Description

Our method predicts global planar reflective symmetry of a given 3D shape. It inputs the voxelized shape and uses 3D convolutional layers to extract global feature, and then output the parameters of each planes. Moreover, we add a regularization loss to ensure the network not produce multiple, near-identical outputs. And We further provide a method to remove invalid and duplicated planes. We demonstrate that our method is able to produce reliable and accurate results.

## Prerequisites

1. System

    - **Ubuntu 16.04 or later**
    - **NVIDIA GPU + CUDA 10.0 cuDNN 7.6.1**

2. Software

    - Python 3.7

        ```shell
        bash install.sh
        ```

    - MATLAB R2018b or later


## Reproduce

Run `source ~/prsnet/bin/activate;python test.py --dataroot ./datasets/rep --name last` to get the results in `results` directory.


1. Shape completion (Fig. 9 in the paper).

The parameters of detected planes are in `results/last/test_latest/com_piano.mat`. To visualize the results, please run `visual_completion.m` in MATLAB. The generated `partial_piano.obj` shows the partial piano shape, and `partial_piano_plane.obj` shows the detected plane. `leg.ply` shows the completed leg.

3. Robustness testing (Fig. 11 in the paper).

The parameters of detected planes are in  `results/last/test_latest/partial_piano.mat`. To visualize the results, please run `visual_robust.m` in MATLAB. The generated `robust_piano.obj` shows the partial piano shape, and `error.obj` shows the error heatmap. 

(**NOTE**: We use [SAP 3D Visual Enterprise Author 9.0](https://www.sap.com/hk/products/product-visualization.html) for visualization. [MeshLab](https://www.meshlab.net/) also can visualize shapes but cannot properly visualize heatmap.)


## Citation
If you found this code useful please cite our work as:

    @ARTICLE{9127500,
        author={L. {Gao} and L. -X. {Zhang} and H. -Y. {Meng} and Y. -H. {Ren} and Y. -K. {Lai} and L. {Kobbelt}},
        title={PRS-Net: Planar Reflective Symmetry Detection Net for 3D Models},
        journal={IEEE Transactions on Visualization and Computer Graphics},
        year = {2020},
        volume = {},
        pages = {1-1},
        number = {},
        doi={10.1109/TVCG.2020.3003823}
    }
