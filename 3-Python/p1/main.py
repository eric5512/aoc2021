with open("input.txt", "rt") as file:
    text = file.read().splitlines()

size = len(text[0])
length = len(text)

ones = [0 for _ in range(size)]

for s in text:
    for i, c in enumerate(s):
        if c == '1':
            ones[i] += 1

gamma = ""
epsilon = ""

for i in ones:
    if i > (length/2):
        gamma += '1'
        epsilon += '0'
    else:
        gamma += '0'
        epsilon += '1'

print(int(gamma, base=2)*int(epsilon, base=2))