import numpy as np
import cv2
def file2img():
    file = open("imagen_mejorada.txt").readlines()
    array = np.zeros((256,256),dtype=np.uint8)
    cont =0
    for i in range(256):
        for j in range(256):
            array[i,j]=int(file[cont],2)
            cont +=1
    cv2.imwrite("prueba2.png", array)
file2img()
