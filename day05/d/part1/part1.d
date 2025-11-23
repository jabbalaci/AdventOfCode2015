#!/usr/bin/env rdmd

import std.algorithm;
import std.file;
import std.regex;
import std.stdio;
import std.string;

const VOWELS = "aeiou";

int count_vowels(const string s) pure
{
    int cnt = 0;
    foreach (c; s)
    {
        if (VOWELS.canFind(c))
        {
            ++cnt;
        }
    }
    return cnt;
}

bool is_nice(const string s)
{
    if (matchFirst(s, regex(r"ab|cd|pq|xy")))
    {
        return false;
    }
    // else
    bool vowels_ok = (count_vowels(s) >= 3);
    auto m = matchFirst(s, regex(r"(.)\1"));
    return vowels_ok && m;
}

void main()
{
    // const s = "ugknbfddgicrmopn"; // nice
    // const s = "aaa"; // nice
    // const s = "jchzalrnumimnmhp"; // naughty
    // const s = "haegwjzuvuyypxyu"; // naughty
    // const s = "dvszwmarrgswjxmb"; // naughty

    const lines = readText("input.txt").splitLines;

    int result = 0;
    foreach (s; lines)
    {
        if (is_nice(s))
        {
            ++result;
        }
    }
    writeln(result);
}
