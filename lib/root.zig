//! By convention, root.zig is the root source file when making a library. If
//! you are making an executable, the convention is to delete this file and
//! start with main.zig instead.
const std = @import("std");
const testing = std.testing;
const fixtures = @import("test_fixtures.zig");

pub fn EditDistance(alloc: std.mem.Allocator, query: []const u8, base: []const u8) u32 {
    _ = alloc;
    // if (std.mem.eql(u8, query, base)) {
    //     return 0;
    // }

    return Lcs(query, base);
}

fn Lcs(lhs: []const u8, rhs: []const u8) u8 {
    if (std.mem.eql(u8, lhs, "") or std.mem.eql(u8, rhs, "")) {
        return 0;
    }
    if (lhs[lhs.len - 1] == rhs[rhs.len - 1]) {
        return 1 + Lcs(lhs[0 .. lhs.len - 1], rhs[0 .. rhs.len - 1]);
    } else {
        return @max(Lcs(lhs[0 .. lhs.len - 1], rhs), Lcs(lhs, rhs[0 .. rhs.len - 1]));
    }
}

test "LCS 2" {
    try testing.expectEqual(2, Lcs("aab", "azb"));
}

test "LCS 3" {
    try testing.expectEqual(3, Lcs("abcdgh", "aedfhr"));
}

test "LCS 4" {
    try testing.expectEqual(4, Lcs("aggtab", "gxtxayb"));
}
test "identical files" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 0), Lcs("", ""));
}

test "empty base, single addition" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 1), Lcs("a", ""));
}

test "single deletion" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 1), Lcs("", "a"));
}

test "no changes" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 0), Lcs("same", "same"));
}

test "single char addition" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 1), Lcs("cats", "cat"));
}

test "single char deletion" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 1), Lcs("cat", "cats"));
}

test "single char substitution" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 1), Lcs("bat", "cat"));
}

test "middle insertion" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 1), Lcs("abc", "ac"));
}
//
test "middle deletion" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 1), Lcs("ac", "abc"));
}
//
test "prefix addition" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 6), Lcs("hello world", "world"));
}

test "suffix addition" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 6), Lcs("hello world", "hello"));
}

test "word replacement" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 7), Lcs("goodbye world", "hello world"));
}

test "complete rewrite" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 3), Lcs("xyz", "abc"));
}

test "single line addition" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 7), Lcs("line1\nline2", "line1"));
}

test "line removal" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 7), Lcs("line1", "line1\nline2"));
}

test "line modification" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 4), Lcs("new line", "old line"));
}

test "blank line addition" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 1), Lcs("line1\n\nline2", "line1\nline2"));
}

test "variable rename" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 1), Lcs("var y = 1", "var x = 1"));
}

test "function rename" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 7), Lcs("def goodbye():", "def hello():"));
}

test "string literal change" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 5), Lcs("print(\"world\")", "print(\"hello\")"));
}

test "comment addition" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 11), Lcs("x = 1  # counter", "x = 1"));
}

test "trailing whitespace" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 1), Lcs("hello ", "hello"));
}

test "indentation change" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 4), Lcs("        code", "    code"));
}

test "tab to spaces" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 4), Lcs("    code", "\tcode"));
}

test "newline variations" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 1), Lcs("line1\r\nline2", "line1\nline2"));
}

test "line reordering" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 4), Lcs("A\nC\nB", "A\nB\nC"));
}

test "block movement" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 14), Lcs("func2()\nfunc1()", "func1()\nfunc2()"));
}

test "nested changes" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 6), Lcs("if (false) { x = 2; }", "if (true) { x = 1; }"));
}

test "repeated characters" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 4), Lcs("bbbb", "aaaa"));
}

test "long common prefix" {
    return error.SkipZigTest;
    // try testing.expectEqual(@as(u32, 9), Lcs("same_prefix_changed", "same_prefix_different"));
}

test "long common suffix" {
    return error.SkipZigTest;
    // try testing.expectEqual(@as(u32, 9), Lcs("changed_same_suffix", "different_same_suffix"));
}

test "alternating pattern" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 4), Lcs("baba", "abab"));
}

test "import statement change" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 12), Lcs("import numpy as np", "import math"));
}

test "method signature change" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 3), Lcs("def calc(x, y):", "def calc(x):"));
}

test "error message update" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 10), Lcs("Error: operation failed", "Error: failed"));
}

test "version number bump" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 1), Lcs("version = \"1.0.1\"", "version = \"1.0.0\""));
}
