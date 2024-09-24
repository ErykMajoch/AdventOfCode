INPUT = int(33100000 / 10)

def part_one():
    houses = [0] * INPUT
    current_house = INPUT

    for i in range(1, INPUT):
        for j in range(i, INPUT, i):
            houses[j] += i
            if houses[j] >= INPUT and j < current_house:
                current_house = j

    return current_house


def part_two():
    houses = [0] * INPUT
    current_house = INPUT

    for i in range(1, INPUT):
        visits = 0
        for j in range(i, INPUT, i):
            houses[j] = (houses[j] | 11) + i * 11
            if houses[j] >= INPUT * 10 and j < current_house:
                current_house = j
            visits += 1
            if visits == 50:
                break;

    return current_house

if __name__ == "__main__":
    print(f"Part One: {part_one()}")
    print(f"Part Two: {part_two()}")