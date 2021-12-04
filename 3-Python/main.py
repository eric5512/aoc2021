with open("input.txt", "rt") as file:
    text = file.read().splitlines()

size = len(text[0])
length = len(text)

ones = [0 for _ in range(size)]

for s in text:
    for i, c in enumerate(s):
        if c == '1':
            ones[i] += 1

criteria   = "".join(['1' if i >= (length//2) else '0' for i in ones])
criteriant = "".join(['0' if i >= (length//2) else '1' for i in ones])

def filter_with_criteria(l, crit):
    aux = { i for i in l }
    length = len(l)
    count = 0
    while len(aux) > 1 and count < length:
        aux = { i for i in aux if i[count] == crit[count]}
        count += 1
    
    assert len(aux) == 1, "Something went wrong"
    return aux.pop()

oxigen = int(filter_with_criteria(text, criteria), base=2)
co2    = int(filter_with_criteria(text, criteriant), base=2)

print(oxigen*co2)