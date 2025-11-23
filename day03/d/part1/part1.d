#!/usr/bin/env rdmd

import std.stdio;
import std.file;
import std.string;
import std.typecons;

void main()
{
    // const string fname = "example1.txt";
    // const string fname = "example2.txt";
    // const string fname = "example3.txt";
    const string fname = "input.txt";

    bool[Tuple!(int, int)] d;
    int x = 0, y = 0;
    d[tuple(0, 0)] = true;

    string content = readText(fname).strip();
    foreach (c; content)
    {
        // dfmt off
        if (c == '^') {
            ++y;
        } else if (c == '>') {
            ++x;
        } else if (c == 'v') {
            --y;
        } else if (c == '<') {
            --x;
        } else {
            assert(0);
        }
        // dfmt on
        d[tuple(x, y)] = true;
    }
    writeln(d.length);
}
