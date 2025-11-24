#!/usr/bin/env rdmd

import std.algorithm;
import std.ascii;
import std.conv;
import std.file;
import std.stdio;
import std.string; // all()

enum MAX = 65_536;

void process(const string[] lines)
{
    int[string] d;

    // 1st pass
    foreach (line; lines)
    {
        auto parts = line.split();
        if (parts.length == 3 && parts[0].all!(isDigit)) // value -> register
        {
            d[parts[$ - 1]] = parts[0].to!int;
        }
    }
    // repeated passes
    while (true)
    {
        if ("a" in d)
        {
            break;
        }
        // else
        foreach (line; lines)
        {
            auto parts = line.split();
            if (parts.length == 3 && parts[0] in d) // reg. value -> register
            {
                d[parts[$ - 1]] = d[parts[0]];
            }
            else // if (parts.length > 3) // other lines
            {
                // NOT
                if (parts[0] == "NOT" && parts[1] in d)
                {
                    int value = ~d[parts[1]];
                    if (value < 0)
                    {
                        value += MAX;
                    }
                    d[parts[$ - 1]] = value;
                }
                // AND
                if (parts[1] == "AND")
                {
                    if (parts[2] in d)
                    {
                        int value;
                        if (parts[0] in d)
                        {
                            value = d[parts[0]] & d[parts[2]];
                        }
                        if (parts[0].all!(isDigit))
                        {
                            value = parts[0].to!int & d[parts[2]];
                        }
                        d[parts[$ - 1]] = value;
                    }
                }
                // OR
                if (parts[1] == "OR" && parts[0] in d && parts[2] in d)
                {
                    int value = d[parts[0]] | d[parts[2]];
                    d[parts[$ - 1]] = value;
                }
                // LSHIFT
                if (parts[1] == "LSHIFT" && parts[0] in d)
                {
                    int value = d[parts[0]] << parts[2].to!int;
                    d[parts[$ - 1]] = value;
                }
                // RSHIFT
                if (parts[1] == "RSHIFT" && parts[0] in d)
                {
                    int value = d[parts[0]] >> parts[2].to!int;
                    d[parts[$ - 1]] = value;
                }
            }
        }
    }
    // writeln(d);
    writeln(d["a"]);
}

void main()
{
    // const fname = "example.txt";
    const fname = "input.txt";

    const lines = readText(fname).splitLines;

    process(lines);
}
