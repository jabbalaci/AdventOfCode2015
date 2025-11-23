#!/usr/bin/env rdmd

import std.file;
import std.stdio;
import std.string;

int process(const string s) pure
{
    int result = 0;

    foreach (c; s)
    {
        if (c == '(')
            ++result;
        else if (c == ')')
            --result;
        else
            assert(0);
    }

    return result;
}

void main()
{
    // const example = "(())"; // 0
    // const example = "()()"; // 0
    // const example = "((("; // 3
    // const example = "(()(()("; // 3
    // const example = "))((((("; // 3
    // const example = "())"; // -1
    // const example = "))("; // -1
    // const example = ")))"; // -3
    // const example = ")())())"; // -3

    string content = readText("input.txt").strip();

    // int result = process(example);
    int result = process(content);
    writeln(result);
}
