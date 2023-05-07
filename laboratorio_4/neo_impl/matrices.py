m1 = [[1, 2, 3, 4],
      [1, 2, 3, 5],
      [1, 2, 3, 6],
      [1, 2, 3, 7]]


# refleja en y
def wu(m):
    mabajo = [[0,0,0,0], [0,0,0,0],[0,0,0,0],[0,0,0,0]] # solo la inicia
    mderecha = [[0,0,0,0], [0,0,0,0],[0,0,0,0],[0,0,0,0]] # solo la inicia
    marriba = [[0,0,0,0], [0,0,0,0],[0,0,0,0],[0,0,0,0]] # solo la inicia
    mrara = [[0,0,0,0], [0,0,0,0],[0,0,0,0],[0,0,0,0]] # solo la inicia
    for i in range(0,4):
        for j in range(0,4):
            mabajo[i][j] = m[j][i]
            mderecha[i][j] = m[i][3-j]
            marriba[3-j][i] = m[i][j] 
            mrara[j][3-i] = m[i][j] 
    return [mabajo, mderecha, marriba, mrara];  

r = wu(m1)
print(r[2])
print(wu(r[2])[3])

"""
reflejada (merge derecha)

[4 3 2 1]
[4 3 2 1]
[4 3 2 1]
[4 3 2 1]


rotada +90 (merge arriba)

[4 4 4 4]
[3 3 3 3]
[2 2 2 2]
[1 1 1 1]

rotada -90 (merge abajo) transpuesta

[1 1 1 1]
[2 2 2 2]
[3 3 3 3]
[4 4 4 4]

"""