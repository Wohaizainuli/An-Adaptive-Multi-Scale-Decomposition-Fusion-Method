# AMSD： An Adaptive Multi-Scale Decomposition Fusion Method for Remote Sensing Multispectral and Panchromatic Images

> This repository provides a non-official and simplified version of our implementation, intended solely for academic communication and preliminary understanding.  
> To protect the originality of our work and ensure compliance with data and intellectual property considerations, the **complete codebase will be released after the paper is officially published**.  
> We appreciate your understanding and support.


## 🔹 Framework Overview

The structure of **AMSD** is illustrated in the figure below:

![image](https://github.com/Wohaizainuli/An-Adaptive-Multi-Scale-Decomposition-Fusion-Method/blob/main/Figure/1.jpg)

*Fig. 1: Overall Architecture of AMSD.*

The proposed algorithm framework is shown in Figure 1 and consists of three main stages: decomposition, fusion and reconstruction. During the decomposition process, the MS image is first converted through color space conversion (CSC) to obtain the spectral component (SEC) and the spatial component (SAC). At the same time, the structural attenuation (SA) index of SAC relative to the PAN image is calculated. Then the SA is used to guide the adaptive multi-scale decomposition (AMSD) to decompose the PAN image into a series of high-frequency components (HF) as well as a low-frequency component (LF), where LF shares a spatial structure similar to the SAC of the MS image.These two components are used to generate the fused low-frequency component (FLF) through the fusion module. The inverse transformation iAMSD then combines the FLF with the high-frequency components to reconstruct the fused spatial component (FSAC). Finally, the inverse color space conversion (iCSC) combines FSAC with the spectral component SEC to produce the final fused result.

## 🔹 Dataset
The dataset used in this paper is a non-public dataset, which may involve the rights of other researchers. It can be obtained by contacting the authors upon a reasonable request. Thank you for your understanding!
The code repository only provides 7 pairs of MS-PAN images in `Image/` for communication, learning, and discussion.The seven pairs of MS-PAN images provided are generated through smoothing and grayscale transformation techniques to create  simulated images.

## 🔹 Code
🔴 The format provided in the code repository is for understanding and communication purposes only. When using it, make sure to place all the code in the same directory.  
The overall structure of the proposed method can be referenced in `AMSD.m` and can be understood in conjunction with Figure 1.The core functionality of the code can be referenced in `model/`.For example, the code for calculating the similarity metric SA is placed in the `model/alfs`. folder.
The `utils/` folder contains a series of script files, such as those for color space conversion.




## 🔹 Result
The partial fusion results of AMSD are displayed in the figure below.

![image](https://github.com/Wohaizainuli/An-Adaptive-Multi-Scale-Decomposition-Fusion-Method/blob/main/Figure/r.jpg)

*Fig. 4: Fusion Results of AMSD.*



## 🔹 Contributing & Contact

Thank you for reading and supporting AMSD! If you have any questions or encounter issues, feel free to open an issue in this repository or contact me directly at **junjiema_xmtra@163.com**.    
We welcome contributions—please fork the repo, make your changes, and submit a pull request.
