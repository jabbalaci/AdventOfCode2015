#!/usr/bin/env python3

# it's here for speed comparison only


def extract_pair(s: str) -> tuple[int, int]:
    a, b = s.split(",")
    return int(a), int(b)


def process_line(d: dict[tuple[int, int], int], line: str):
    parts = line.split()

    # Determine option
    if parts[1] == "on":
        option = "on"
    elif parts[1] == "off":
        option = "off"
    elif parts[0] == "toggle":
        option = "toggle"
    else:
        raise ValueError("Invalid line: " + line)

    if option in ("on", "off"):
        pair1 = extract_pair(parts[2])
        pair2 = extract_pair(parts[-1])
        x1, y1 = pair1
        x2, y2 = pair2

        value = 1 if option == "on" else 0

        for i in range(x1, x2 + 1):
            for j in range(y1, y2 + 1):
                d[(i, j)] = value
    elif option == "toggle":
        pair1 = extract_pair(parts[1])
        pair2 = extract_pair(parts[-1])
        x1, y1 = pair1
        x2, y2 = pair2

        for i in range(x1, x2 + 1):
            for j in range(y1, y2 + 1):
                d[(i, j)] = 1 - d.get((i, j), 0)
    else:
        raise ValueError("Invalid state")


def get_result(d: dict[tuple[int, int], int]) -> int:
    return sum(d.values())


def main():
    # fname = "example1.txt"
    # fname = "example2.txt"
    # fname = "example3.txt"
    fname = "input.txt"

    with open(fname, "r") as f:
        lines = f.read().splitlines()

    d = {}

    for line in lines:
        process_line(d, line)

    result = get_result(d)
    print(result)


if __name__ == "__main__":
    main()
