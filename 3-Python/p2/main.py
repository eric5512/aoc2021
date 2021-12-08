with open("input.txt", "rt") as f:
    data = f.read().splitlines()


def get_num(data, crit):
    size  = len(data[0])
    aux   = { i for i in data }
    count = 0
    while len(aux) > 1 and count < size:
        length = len(aux)
        ones  = sum(1 for i in aux if i[count] == '1')

        c = crit(ones, length)

        aux  = { i for i in aux  if i[count] == c }
        count += 1

    assert len(aux) == 1, "ERROR"
    return aux.pop()

oxigen = get_num(data, lambda x, y: '1' if x >= y/2 else '0')
co2 = get_num(data, lambda x, y: '0' if x >= y/2 else '1')

print(int(oxigen, base=2)*int(co2, base=2))