#!/usr/bin/env rdmd

/*
This solution is buggy due to an error in std.regex .
More info here:
* https://forum.dlang.org/thread/hmwpyrhomcshjmqwkzdx@forum.dlang.org
* https://github.com/dlang/phobos/issues/10152
*/

module part2_workaround;

import std.algorithm;
import std.file;
import std.regex;
import std.stdio;
import std.string;

bool is_nice(const string s)
{
    writeln(s);
    auto m1 = matchFirst(s, regex(r"(..).{0,999999}\1"));
    writeln(m1);
    auto m2 = matchFirst(s, regex(r"(.).\1"));
    writeln(m2);
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
    const s = "xdwduffwgcptfwad"; // python: nice

    writeln(is_nice(s));

    return;

    const lines = readText("input.txt").splitLines;

    int result = 0;
    foreach (line; lines)
    {
        if (is_nice(line))
        {
            ++result;
            writefln("%s: nice", line);
        }
        else
        {
            writefln("%s: naughty", line);
        }
    }
    writeln(result);
}
