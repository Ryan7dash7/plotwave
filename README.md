# plotwave

PLOTWAVE plots waveforms saved by a LeCroy oscilloscope. The waveforms must be saved to CSV, DAT, or TXT files. If a waveform is saved to a DAT or TXT file, the filename must start with 'C1', 'C2', 'C3', or 'C4'.

PLOTWAVE([CH1 CH2 CH3 CH4]) plots only the selected channels. CH is a logical used to select which channels to plot.

PLOTWAVE([CH1 CH2 CH3 CH4],[G1 G2 G3 G4]) applies a gain G to each channel.

Version 2017.08.14  
Copyright 2017 Ryan McGowan
