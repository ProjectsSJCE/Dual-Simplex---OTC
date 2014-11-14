objective_str = str(raw_input())
objective = objective_str.split()

equations = []
n = int(raw_input())
for i in range(n):
    line = str(raw_input())
    equations.append([line.split()])

print objective
print equations
