# Deep Generative Network for Structured Deformable Mesh

![](./teaser.jpg)

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
        sh install.sh
        ```

    - MATLAB R2018b or later


## Data and Checkpoint

All the [data](https://drive.google.com/file/d/1myWnHmuk2XD7lyHJL7KAgok89DT7SETF/view?usp=sharing) and [checkpoint](https://drive.google.com/file/d/1ItmG9tQ7vEE31anDU_z2yER2Wdon9_Ez/view?usp=sharing) used to reproduce the result is stored in google drive. Links are also available in `data_checkpoint_link.txt`. Save the two zip files in current directory. 

After downloading the data and checkpoint, the directory tree looks like this:

```txt
── SDMNET_stamp
   ├── checkpoint
   ├── code
   ├── data
   ├── data_checkpoint_link.txt
   ├── install.sh
   ├── liability form.pdf
   ├── introduction.txt
   ├── mvdata.sh
   ├── README.md
   └── teaser.jpg
```

Then execute:
```sh
unzip data.zip
cp ./data/chair* ./code/python/chair_reproduce
cp ./data/plane* ./code/python/plane_reproduce

unzip checkpoint.zip
mv ./checkpoint/05060123_6863bin_1-joint_1-l0_100.0-l2_10.0-l3_1.0-l4_0.001-model_chair-trcet_1.0 ./code/python/chair_reproduce
mv ./checkpoint/05050238_2556bin_0-joint_0-l0_100.0-l2_10.0-l3_1.0-l4_0.001-model_plane-trcet_1.0 ./code/python/plane_reproduce
```

## Reproduce

1. Interpolation between shapes

   ```shell
   cd ./code/python/plane_reproduce
   CUDA_VISIBLE_DEVICES='' python ./test_stacknewvae.py --output_dir ./05050238_2556bin_0-joint_0-l0_100.0-l2_10.0-l3_1.0-l4_0.001-model_plane-trcet_1.0 --interids  '1f5537f4747ec847622c69c3abc6f80' 'f16381a160f20bc4a3b534252984039' 'efbb9337b9bd3cab56ed1d365b05390d'
   
   cd ../chair_reproduce
   CUDA_VISIBLE_DEVICES='' python ./test_stacknewvae.py --output_dir ./05060123_6863bin_1-joint_1-l0_100.0-l2_10.0-l3_1.0-l4_0.001-model_chair-trcet_1.0 --interids '4e664dae1bafe49f19fb4103277a6b93' '1c17cc67b8c747c3febad4f49b26ec52' '2bbf00f0c583fd8a4b3c42e318f3affc'
   ```

   After running the command, interpolated meshes are saved to a sub directory `interpolationxxxx`  in the checkpoint directory specified by `--output_dir` argument,  `./05050238_2556bin_0-joint_0-l0_100.0-l2_10.0-l3_1.0-l4_0.001-model_plane-trcet_1.0/interpolation80000`for example.

2. Postprocess

   Open `./code/matlab` in MATLAB. Execute following commands.

   ```matlab
   GetOptimizedObj('../python/plane_reproduce/05050238_2556bin_0-joint_0-l0_100.0-l2_10.0-l3_1.0-l4_0.001-model_plane-trcet_1.0/interpolation80000', 'plane', 2, 0, 0)
    
   GetOptimizedObj('../python/chair_reproduce/05060123_6863bin_1-joint_1-l0_100.0-l2_10.0-l3_1.0-l4_0.001-model_chair-trcet_1.0/interpolation100000', 'chair', 2, 0, 0)
   ```

   The output meshes are in `../python/plane_reproduce/05050238_2556bin_0-joint_0-l0_100.0-l2_10.0-l3_1.0-l4_0.001-model_plane-trcet_1.0/interpolation80000` and `../python/chair_reproduce/05060123_6863bin_1-joint_1-l0_100.0-l2_10.0-l3_1.0-l4_0.001-model_chair-trcet_1.0/interpolation100000`.

   Open those meshes in meshlab and you will see the reproduced results for **Fig.1** in the original paper. (**NOTE**: Some parts' faces might have wrong normals, use **double face** mode for beter visualization)

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