import os
import numpy as np

pixel = 256*256 #variable global

def main():
    imagen = open("imagen.txt").readlines() #lee el txt
    array_I=procesar_img(imagen)
    nueva= ecualizar(array_I)
    crear_archivo(nueva)

def crear_archivo(imagen_nueva): #Funcion que crea el txt de salida del histograma ecualizado
    output = open("imagen_mejorada.txt","w")
    for i in range(pixel):
        output.write(format(imagen_nueva[i] & 0xFF, "08b")+ "\n")
    output.close()


def procesar_img(imagen):
    f_conv = []
    for i in range(pixel):
        f_conv.append(int(imagen[i],2))
    return f_conv
    

def ecualizar(imagen):
    fi = np.zeros(256)
    cuf = np.zeros(256)
    cuf_norm =np.zeros(256)
    histograma = np.zeros(256)
    for i in range (pixel): # se obtiene la frecuencia de distribución
        fi[imagen[i]] = fi[imagen[i]]+1
    cuf[0] = fi[0]
    for i in range(1,256): #Se calcula la frecuencia acumulada
        cuf[i] = cuf[i-1]+fi[i]
    promedio = int(cuf[255]/256)
    norm = [promedio]*256
    norm[127] += cuf[255] % 256
    cuf_norm[0] = norm[0]
    for i in range(1,256): #Se calcula la frecuencia acumulada de la normalización
        cuf_norm[i] = cuf_norm[i-1]+norm[i]
    for i in range(256): #Hace la nueva I, según los valores de frecuencia acumulada y cuf_norm, es decir si I = 6 -----> cuf= 5, el valor más cercano a cuf en cuf_norm es 7 y eso pasa en I=8
        i_prima = 0           # entonces donde antes era I=6, ahora es I=8. Si no se entiende ver espe xd
        i_prima_prev = 0
        diff_prev = cuf[i] # diferencia inicial
        diff_actual = 0 
        for j in range(256):
            i_prima = j
            cufeq = cuf_norm[j]
            if(cufeq >= cuf[i]):
                diff_actual = cufeq - cuf[i] 
            else:
                diff_actual = cuf[i] - cufeq 
            if(diff_actual > diff_prev):
                i_prima = i_prima_prev
                break;
            else:
                diff_prev = diff_actual
                i_prima_prev = i_prima
        histograma[i]=i_prima #Define el nuevo valor de I  antes era 5 -----> 2
    nueva=np.zeros(pixel,dtype=np.uint8) #se crea la matriz con los valores nuevos
    for i in range(pixel): # Aqui se sustituyen todos los valores de la imagen original, por los obtenidos en el histograma, por ejemplo todos los pixeles de valor 8 pasan a ser 3
        nueva[i]=histograma[imagen[i]]

    f = open("datos.txt", 'w')
    for i in range(256):
        f.write("valor {:4}: {:8} | {:8} | {:8} | {:8} \n".format(i, fi[i], cuf[i], cuf_norm[i], histograma[i]))
    f.close()
    return nueva

main()
