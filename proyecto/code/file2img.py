import cv2
import argparse
import numpy as np
import textwrap

ap = argparse.ArgumentParser()
ap.add_argument("-i","--input", required=True,help="name of input txt file")
ap.add_argument("-o","--output", required=True,help="name of input txt file")
ap.add_argument("-s","--size", required=True,help="image row and column pixel size")

args = vars(ap.parse_args())

fileImage = open(args["input"],'r')

rows = int(args["size"])
cols = int(args["size"])

img = np.zeros((rows,cols,1), np.uint8)

for i in range(rows):
    for j in range(cols):
        pixel = fileImage.readline()
        pixel = pixel.strip('\n')
        pixel = int(pixel,2)
        img[i,j] = int(pixel)

cv2.imwrite(args["output"],img)
cv2.imshow('Binary',img)
cv2.waitKey(0)
