#!/usr/bin/env rdmd

import std.conv;
import std.stdio;
import std.string;

string md5Hex(const string s) pure
{
    import std.digest.md : md5Of;
    import std.format : format;

    return format("%(%02x%)", md5Of(s));
}

int find_result(const string base)
{
    int n = 1;
    while (true)
    {
        string s = base ~ n.to!string;
        if (md5Hex(s).startsWith("00000"))
        {
            break;
        }
        ++n;
    }
    return n;
}

void main()
{
    // const string base = "abcdef"; // example 1, result: 609043
    // const string base = "pqrstuv"; // example 2, result: 1048970
    // const string base = "ckczppom"; // my secret key

    // int result = find_result(base);
    // writeln(result);
    writeln(md5Hex("test"));
}
