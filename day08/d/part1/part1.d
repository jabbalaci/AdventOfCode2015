#!/usr/bin/env rdmd

import std.algorithm;
import std.array;
import std.file;
import std.regex;
import std.stdio;
import std.string;
import std.typecons;

alias Pair = Tuple!(int, int);

string[] findAll(const string re, const string text)
{
    return text.matchAll(regex(re)).map!(m => m[1]).array;
}

Pair process(const string line)
{
    string s = line[1 .. $ - 1];
    s = s.replace(`\\`, ".");
    s = s.replace(`\"`, ".");
    s = s.replaceAll(regex(`\\x[0-9a-f]{2}`), ".");

    return tuple(cast(int) line.length, cast(int) s.length);
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
