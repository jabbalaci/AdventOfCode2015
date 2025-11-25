#!/usr/bin/env rdmd

import std.file;
import std.stdio;
import std.string;
import std.typecons;

alias Pair = Tuple!(int, int);

Pair process(const string line)
{
    char[] s;
    s ~= '"';
    foreach (c; line)
    {
        switch (c)
        {
        case '"':
            s ~= `\"`;
            break;
        case '\\':
            s ~= `\\`;
            break;
        default:
            s ~= c;
        }
    }
    s ~= '"';

    return tuple(cast(int) s.length, cast(int) line.length);
}

void main()
{
    // const fname = "example.txt";
    const fname = "input.txt";

    const lines = readText(fname).splitLines;

    int total = 0;
    foreach (line; lines)
    {
        auto t = process(line);
        total += t[0] - t[1];
    }
    writeln(total);
}
