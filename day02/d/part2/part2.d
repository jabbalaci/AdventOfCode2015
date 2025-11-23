#!/usr/bin/env rdmd

import std.algorithm;
import std.conv;
import std.file;
import std.stdio;
import std.string;

void example()
{
    // int l = 2, w = 3, h = 4;
    int l = 1, w = 1, h = 10;
    int[] values = [l, w, h];
    values.sort();
    int result = values[0] * 2 + values[1] * 2;
    result += l * w * h;
    writeln(result);
}

int ribbon(const int l, const int w, const int h) pure
{
    int[] values = [l, w, h];
    values.sort();
    int result = values[0] * 2 + values[1] * 2;
    result += l * w * h;
    return result;
}

void main()
{
    // example();
    auto lines = readText("input.txt").splitLines;
    int result = 0;
    foreach (line; lines)
    {
        auto parts = line.split("x");
        assert(parts.length == 3);
        int l = parts[0].to!int;
        int w = parts[1].to!int;
        int h = parts[2].to!int;
        result += ribbon(l, w, h);
    }
    writeln(result);
}
