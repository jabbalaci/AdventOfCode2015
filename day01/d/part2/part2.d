#!/usr/bin/env rdmd

import std.file;
import std.stdio;
import std.string;

int process(const string s) pure
{
    int floor = 0;

    foreach (i, c; s)
    {
        if (c == '(')
            ++floor;
        else if (c == ')')
            --floor;
        else
            assert(0); // we should never get here

        if (floor == -1)
        {
            return cast(int) i + 1; // human-friendly indexing
        }
    }

    assert(0); // we should never get here
}

void main()
{
    // const example = ")"; // 1
    // const example = "()())"; // 5

    string content = readText("input.txt").strip();

    // int result = process(example);
    int result = process(content);
    writeln(result);
}
