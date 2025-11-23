#!/usr/bin/env rdmd

import std.algorithm;
import std.file;
import std.regex;
import std.stdio;
import std.string;

bool check_first_property(const string s)
{
    for (int i = 0; i < s.length - 2; ++i)
    {
        auto pre = s[i .. i + 2];
        auto rest = s[i + 2 .. $];
        if (rest.canFind(pre))
        {
            return true;
        }
    }
    return false;
}

bool is_nice(const string s)
{
    // writeln(s);
    auto m1 = check_first_property(s);
    // writeln(m1);
    auto m2 = matchFirst(s, regex(r"(.).\1"));
    // writeln(m2);
    return m1 && m2;
}

void main()
{
    // const s = "qjhvhtzxzqqjkmpb"; // nice
    // const s = "xxyxx"; // nice
    // const s = "aaa"; // naughty
    // const s = "aaaa"; // nice
    // const s = "uurcxstgmygtbstg"; // naughty
    // const s = "ieodomkazucvgmuy"; // naughty
    // const s = "xdwduffwgcptfwad"; // python: nice

    // writeln(is_nice(s));

    // return;

    const lines = readText("input.txt").splitLines;

    int result = 0;
    foreach (line; lines)
    {
        if (is_nice(line))
        {
            ++result;
            // writefln("%s: nice", line);
        }
        else
        {
            // writefln("%s: naughty", line);
        }
    }
    writeln(result);
}
