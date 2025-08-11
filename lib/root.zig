//! By convention, root.zig is the root source file when making a library. If
//! you are making an executable, the convention is to delete this file and
//! start with main.zig instead.
const std = @import("std");
const testing = std.testing;
const fixtures = @import("test_fixtures.zig");

pub fn editDistance(alloc: std.mem.Allocator, query: []const u8, base: []const u8) u32 {
    if (std.mem.eql(u8, query, base)) {
        return 0;
    }

    var v = std.ArrayList(u8).initCapacity(alloc, query.len + 1 * base.len + 1);
    for (0..v.len) |k| {
        if (query[k] == base[k]) {
            v[k] = 0;
        }
    }

    return 1;
}

test "identical files" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 0), editDistance(testing.allocator, "", ""));
}

test "empty base, single addition" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 1), editDistance(testing.allocator, "a", ""));
}

test "single deletion" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 1), editDistance(testing.allocator, "", "a"));
}

test "no changes" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 0), editDistance(testing.allocator, "same", "same"));
}

test "single char addition" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 1), editDistance(testing.allocator, "cats", "cat"));
}

test "single char deletion" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 1), editDistance(testing.allocator, "cat", "cats"));
}

test "single char substitution" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 1), editDistance(testing.allocator, "bat", "cat"));
}

test "middle insertion" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 1), editDistance(testing.allocator, "abc", "ac"));
}
//
test "middle deletion" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 1), editDistance(testing.allocator, "ac", "abc"));
}
//
test "prefix addition" {
    // return error.SkipZigTest;
    try testing.expectEqual(@as(u32, 6), editDistance(testing.allocator, "hello world", "world"));
}
//
// test "suffix addition" {
//     // return error.SkipZigTest;
//     try testing.expectEqual(@as(u32, 6), editDistance("hello world", "hello"));
// }
//
// test "word replacement" {
//     // return error.SkipZigTest;
//     try testing.expectEqual(@as(u32, 7), editDistance("goodbye world", "hello world"));
// }
//
// test "complete rewrite" {
//     // return error.SkipZigTest;
//     try testing.expectEqual(@as(u32, 3), editDistance("xyz", "abc"));
// }
//
// test "single line addition" {
//     // return error.SkipZigTest;
//     try testing.expectEqual(@as(u32, 7), editDistance("line1\nline2", "line1"));
// }
//
// test "line removal" {
//     // return error.SkipZigTest;
//     try testing.expectEqual(@as(u32, 7), editDistance("line1", "line1\nline2"));
// }
//
// test "line modification" {
//     // return error.SkipZigTest;
//     try testing.expectEqual(@as(u32, 4), editDistance("new line", "old line"));
// }
//
// test "blank line addition" {
//     // return error.SkipZigTest;
//     try testing.expectEqual(@as(u32, 1), editDistance("line1\n\nline2", "line1\nline2"));
// }
//
// test "variable rename" {
//     // return error.SkipZigTest;
//     try testing.expectEqual(@as(u32, 1), editDistance("var y = 1", "var x = 1"));
// }
//
// test "function rename" {
//     // return error.SkipZigTest;
//     try testing.expectEqual(@as(u32, 7), editDistance("def goodbye():", "def hello():"));
// }
//
// test "string literal change" {
//     // return error.SkipZigTest;
//     try testing.expectEqual(@as(u32, 5), editDistance("print(\"world\")", "print(\"hello\")"));
// }
//
// test "comment addition" {
//     // return error.SkipZigTest;
//     try testing.expectEqual(@as(u32, 11), editDistance("x = 1  # counter", "x = 1"));
// }
//
// test "trailing whitespace" {
//     // return error.SkipZigTest;
//     try testing.expectEqual(@as(u32, 1), editDistance("hello ", "hello"));
// }
//
// test "indentation change" {
//     // return error.SkipZigTest;
//     try testing.expectEqual(@as(u32, 4), editDistance("        code", "    code"));
// }
//
// test "tab to spaces" {
//     // return error.SkipZigTest;
//     try testing.expectEqual(@as(u32, 4), editDistance("    code", "\tcode"));
// }
//
// test "newline variations" {
//     // return error.SkipZigTest;
//     try testing.expectEqual(@as(u32, 1), editDistance("line1\r\nline2", "line1\nline2"));
// }
//
// test "line reordering" {
//     // return error.SkipZigTest;
//     try testing.expectEqual(@as(u32, 4), editDistance("A\nC\nB", "A\nB\nC"));
// }
//
// test "block movement" {
//     // return error.SkipZigTest;
//     try testing.expectEqual(@as(u32, 14), editDistance("func2()\nfunc1()", "func1()\nfunc2()"));
// }
//
// test "nested changes" {
//     // return error.SkipZigTest;
//     try testing.expectEqual(@as(u32, 6), editDistance("if (false) { x = 2; }", "if (true) { x = 1; }"));
// }
//
// test "repeated characters" {
//     // return error.SkipZigTest;
//     try testing.expectEqual(@as(u32, 4), editDistance("bbbb", "aaaa"));
// }
//
// test "long common prefix" {
//     // return error.SkipZigTest;
//     try testing.expectEqual(@as(u32, 9), editDistance("same_prefix_changed", "same_prefix_different"));
// }
//
// test "long common suffix" {
//     // return error.SkipZigTest;
//     try testing.expectEqual(@as(u32, 9), editDistance("changed_same_suffix", "different_same_suffix"));
// }
//
// test "alternating pattern" {
//     // return error.SkipZigTest;
//     try testing.expectEqual(@as(u32, 4), editDistance("baba", "abab"));
// }
//
// test "import statement change" {
//     // return error.SkipZigTest;
//     try testing.expectEqual(@as(u32, 12), editDistance("import numpy as np", "import math"));
// }
//
// test "method signature change" {
//     // return error.SkipZigTest;
//     try testing.expectEqual(@as(u32, 3), editDistance("def calc(x, y):", "def calc(x):"));
// }
//
// test "error message update" {
//     // return error.SkipZigTest;
//     try testing.expectEqual(@as(u32, 10), editDistance("Error: operation failed", "Error: failed"));
// }
//
// test "version number bump" {
//     // return error.SkipZigTest;
//     try testing.expectEqual(@as(u32, 1), editDistance("version = \"1.0.1\"", "version = \"1.0.0\""));
// }
