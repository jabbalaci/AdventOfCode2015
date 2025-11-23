#!/usr/bin/env rdmd

import std.file;
import std.stdio;
import std.string;
import std.typecons;

struct Person
{
    int x = 0;
    int y = 0;
}

void main()
{
    // const string fname = "example1.txt";
    // const string fname = "example2.txt";
    // const string fname = "example3.txt";
    const string fname = "input.txt";

    bool[Tuple!(int, int)] d;
    Person santa = Person();
    Person robo = Person();
    d[tuple(0, 0)] = true;

    string content = readText(fname).strip();
    foreach (idx, c; content)
    {
        Person* current;
        // dfmt off
        if (idx % 2 == 0) {
            current = &santa;
        } else {
            current = &robo;
        }
        if (c == '^') {
            ++current.y;
        } else if (c == '>') {
            ++current.x;
        } else if (c == 'v') {
            --current.y;
        } else if (c == '<') {
            --current.x;
        } else {
            assert(0);
        }
        // dfmt on
        d[tuple(current.x, current.y)] = true;
    }
    writeln(d.length);
}
