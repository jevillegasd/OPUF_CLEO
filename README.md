# Methods for a performance study of OPUFs under variable input losses
Data analysis for the study of OPUF performance under varied input power levels.

## Usage
Run the main_powerloss script to generate the data analysis on the files stored in the 'files' directory. This will generate the data used in the conference presenattion and you can use the same data processing to analyse any other spectral domain data from optical devices to test their performance as Unclonable Functions.

Here we compute the Hamming Distance as the number of bits that change on the binary represenation of the device response between two different levels of attenuation. The device response is the measured optical insertion loss at a predefined set of wavelengths (the challenge). The set of bits that are actually compared for each power measurement value is abruptibly in the getKey function. This can be changed to any set of bits or all the bits, but in general the most significant bits have a lower variability based on the non-linear optical response. 

## License
MIT License
Juan Esteban Villegas, Photonics Research Lab at NYUAD, 2021
