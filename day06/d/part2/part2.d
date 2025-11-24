#!/usr/bin/env rdmd

import std.algorithm;
import std.conv;
import std.file;
import std.stdio;
import std.string;
import std.typecons;

alias Pair = Tuple!(int, int);

enum Option
{
    off = 0,
    on = 1,
    toggle = 2
}

Pair extract_pair(const string s)
{
    auto parts = s.split(",");
    return tuple(parts[0].to!int, parts[1].to!int);
}

void process_line(ref int[Pair] d, const string line)
{
    auto parts = line.split();
    Option option;
    // dfmt off
    if (parts[1] == "on") {
        option = Option.on;
    } else if (parts[1] == "off") {
        option = Option.off;
    } else if (parts[0] == "toggle") {
        option = Option.toggle;
    } else {
        assert(0);
    }
    // dfmt on

    if (option == Option.on || option == Option.off)
    {
        auto pair1 = extract_pair(parts[2]);
        auto pair2 = extract_pair(parts[$ - 1]);
        int x1 = pair1[0], y1 = pair1[1];
        int x2 = pair2[0], y2 = pair2[1];
        for (int i = x1; i <= x2; ++i)
        {
            for (int j = y1; j <= y2; ++j)
            {
                // dfmt off
                if (option == Option.on) {
                    d[tuple(i, j)] = d.get(tuple(i, j), 0) + 1;
                } else {
                    auto value = d.get(tuple(i, j), 0);
                    --value;
                    if (value < 0) {
                        value = 0;
                    }
                    d[tuple(i, j)] = value;
                }
                // dfmt on
            }
        }
    }
    else if (option == Option.toggle)
    {
        auto pair1 = extract_pair(parts[1]);
        auto pair2 = extract_pair(parts[$ - 1]);
        int x1 = pair1[0], y1 = pair1[1];
        int x2 = pair2[0], y2 = pair2[1];
        for (int i = x1; i <= x2; ++i)
        {
            for (int j = y1; j <= y2; ++j)
            {
                d[tuple(i, j)] = d.get(tuple(i, j), 0) + 2;
            }
        }
    }
    else
    {
        assert(0);
    }
}

int get_result(const int[Pair] d)
{
    // if value is 0: off, 1: on
    return d.byValue.sum;
}

void main()
{
    // const fname = "example1.txt";
    // const fname = "example2.txt";
    // const fname = "example3.txt";
    const fname = "input.txt";

    const lines = readText(fname).splitLines;
    int[Pair] d;

    foreach (line; lines)
    {
        process_line(d, line);
    }
    int result = get_result(d);
    writeln(result);
}
