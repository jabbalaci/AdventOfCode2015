#!/usr/bin/env rdmd

import std.regex;
import std.stdio;

void main()
{
    string text = "baacaa";
    // auto result = matchFirst(text, regex(r"(..).*\1"));  // buggy
    auto result = matchFirst(text, regex(r"(..).{0,999999}\1")); // workaround

    if (result)
    {
        writeln(text);
    }
}
