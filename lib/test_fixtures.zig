pub const TestCase = struct {
    name: []const u8,
    query: []const u8,
    base: []const u8,
    expected: u32,
};

pub const test_cases = [_]TestCase{
    // Basic cases
    .{ .name = "identical files", .base = "", .query = "", .expected = 0 },
    .{ .name = "empty base, single addition", .base = "", .query = "a", .expected = 1 },
    .{ .name = "single deletion", .base = "a", .query = "", .expected = 1 },
    .{ .name = "no changes", .base = "same", .query = "same", .expected = 0 },

    // Simple modifications
    .{ .name = "single char addition", .base = "cat", .query = "cats", .expected = 1 },
    .{ .name = "single char deletion", .base = "cats", .query = "cat", .expected = 1 },
    .{ .name = "single char substitution", .base = "cat", .query = "bat", .expected = 1 },
    .{ .name = "middle insertion", .base = "ac", .query = "abc", .expected = 1 },
    .{ .name = "middle deletion", .base = "abc", .query = "ac", .expected = 1 },

    // Multi-character changes
    .{ .name = "prefix addition", .base = "world", .query = "hello world", .expected = 6 },
    .{ .name = "suffix addition", .base = "hello", .query = "hello world", .expected = 6 },
    .{ .name = "word replacement", .base = "hello world", .query = "goodbye world", .expected = 7 },
    .{ .name = "complete rewrite", .base = "abc", .query = "xyz", .expected = 3 },

    // Line-based scenarios
    .{ .name = "single line addition", .base = "line1", .query = "line1\nline2", .expected = 7 },
    .{ .name = "line removal", .base = "line1\nline2", .query = "line1", .expected = 7 },
    .{ .name = "line modification", .base = "old line", .query = "new line", .expected = 4 },
    .{ .name = "blank line addition", .base = "line1\nline2", .query = "line1\n\nline2", .expected = 1 },

    // Code-like patterns
    .{ .name = "variable rename", .base = "var x = 1", .query = "var y = 1", .expected = 1 },
    .{ .name = "function rename", .base = "def hello():", .query = "def goodbye():", .expected = 7 },
    .{ .name = "string literal change", .base = "print(\"hello\")", .query = "print(\"world\")", .expected = 5 },
    .{ .name = "comment addition", .base = "x = 1", .query = "x = 1  # counter", .expected = 11 },

    // Whitespace variations
    .{ .name = "trailing whitespace", .base = "hello", .query = "hello ", .expected = 1 },
    .{ .name = "indentation change", .base = "    code", .query = "        code", .expected = 4 },
    .{ .name = "tab to spaces", .base = "\tcode", .query = "    code", .expected = 4 },
    .{ .name = "newline variations", .base = "line1\nline2", .query = "line1\r\nline2", .expected = 1 },

    // Complex restructuring
    .{ .name = "line reordering", .base = "A\nB\nC", .query = "A\nC\nB", .expected = 4 },
    .{ .name = "block movement", .base = "func1()\nfunc2()", .query = "func2()\nfunc1()", .expected = 14 },
    .{ .name = "nested changes", .base = "if (true) { x = 1; }", .query = "if (false) { x = 2; }", .expected = 6 },

    // Edge cases
    .{ .name = "repeated characters", .base = "aaaa", .query = "bbbb", .expected = 4 },
    .{ .name = "long common prefix", .base = "same_prefix_different", .query = "same_prefix_changed", .expected = 9 },
    .{ .name = "long common suffix", .base = "different_same_suffix", .query = "changed_same_suffix", .expected = 9 },
    .{ .name = "alternating pattern", .base = "abab", .query = "baba", .expected = 4 },

    // Real-world scenarios
    .{ .name = "import statement change", .base = "import math", .query = "import numpy as np", .expected = 12 },
    .{ .name = "method signature change", .base = "def calc(x):", .query = "def calc(x, y):", .expected = 3 },
    .{ .name = "error message update", .base = "Error: failed", .query = "Error: operation failed", .expected = 10 },
    .{ .name = "version number bump", .base = "version = \"1.0.0\"", .query = "version = \"1.0.1\"", .expected = 1 },
};
