import cv2
import numpy as np
from matplotlib.colors import LinearSegmentedColormap
from matplotlib.cm import get_cmap


# Build color ramps in YCbCr space
filler = np.full(255, 128)
ramp = np.linspace(0, 255, 255)
ch0_ramp = np.rot90(np.dstack((ramp, filler, filler))).astype("uint8")
ch1_ramp = np.rot90(np.dstack((filler, ramp, filler))).astype("uint8")
ch2_ramp = np.rot90(np.dstack((filler, filler, ramp))).astype("uint8")
y_ramp = 1 - (cv2.cvtColor(ch0_ramp, cv2.COLOR_YCrCb2RGB)[:, 0] / 255)
cr_ramp = 1 - cv2.cvtColor(ch1_ramp, cv2.COLOR_YCrCb2RGB)[:, 0] / 255
cb_ramp = 1 - cv2.cvtColor(ch2_ramp, cv2.COLOR_YCrCb2RGB)[:, 0] / 255
cr_map = LinearSegmentedColormap.from_list("Cr", cr_ramp)
cb_map = LinearSegmentedColormap.from_list("Cb", cb_ramp)
