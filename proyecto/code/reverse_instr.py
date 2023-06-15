with open('build/program_be.txt', 'r') as f:
    lista_new = []
    lines = f.readlines()
    for line in lines:
        lista_new.append(line[6] + line[7] + line[4] + line[5] + line[2] + line[3] + line[0] + line[1] + '\n')
    with open('build/program_le.txt', 'w') as dest:
        dest.write(''.join(lista_new))

