#!/usr/bin/env python3

"""
I could find the bug in D thanks to this Python implementation.
"""

import re


def is_nice(s: str) -> bool:
    # pair that appears twice without overlapping
    m1 = re.search(r"(.)(.).*\1\2", s)
    # repeating letter with one between
    m2 = re.search(r"(.).\1", s)
    return bool(m1) and bool(m2)


def main():
    # Test strings
    # print(is_nice("qjhvhtzxzqqjkmpb"))  # nice
    # print(is_nice("xxyxx"))             # nice
    # print(is_nice("aaa"))               # naughty
    # print(is_nice("uurcxstgmygtbstg"))  # naughty
    # print(is_nice("ieodomkazucvgmuy"))  # naughty

    with open("input.txt") as f:
        lines = f.read().splitlines()

    result = 0
    for line in lines:
        if is_nice(line):
            result += 1
            print(f"{line}: nice")
        else:
            print(f"{line}: naughty")

    print(result)


if __name__ == "__main__":
    main()
