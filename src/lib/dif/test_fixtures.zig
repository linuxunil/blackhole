const std = @import("std");

const TestCase = struct {
    name: []const u8,
    query: []const u8,
    reference: []const u8,
    expected: usize,
};

const test_cases = [_]TestCase{
    .{ .name = "both strings empty", .query = "", .reference = "", .expected = 0 },
    .{ .name = "empty to single char", .query = "", .reference = "a", .expected = 1 },
    .{ .name = "single char to empty", .query = "a", .reference = "", .expected = 1 },
    .{ .name = "identical strings", .query = "same", .reference = "same", .expected = 0 },
    .{ .name = "single insertion", .query = "cat", .reference = "cats", .expected = 1 },
    .{ .name = "single deletion", .query = "cats", .reference = "cat", .expected = 1 },
    .{ .name = "single substitution", .query = "cat", .reference = "bat", .expected = 1 },
    .{ .name = "multiple insertions", .query = "abc", .reference = "abcdef", .expected = 3 },
    .{ .name = "multiple deletions", .query = "abcdef", .reference = "abc", .expected = 3 },
    .{ .name = "all substitutions", .query = "abc", .reference = "def", .expected = 3 },
    .{ .name = "mixed operations classic", .query = "kitten", .reference = "sitting", .expected = 3 },
    .{ .name = "mixed operations long", .query = "saturday", .reference = "sunday", .expected = 3 },
    .{ .name = "deletions and substitution", .query = "horse", .reference = "ros", .expected = 3 },
    .{ .name = "complex transformation", .query = "intention", .reference = "execution", .expected = 5 },
    .{ .name = "long string transformation", .query = "algorithm", .reference = "altruistic", .expected = 6 },
    .{ .name = "very different lengths", .query = "a", .reference = "very long string", .expected = 16 },
    .{ .name = "same length all different", .query = "aaaa", .reference = "bbbb", .expected = 4 },
    .{ .name = "character transposition", .query = "abc", .reference = "acb", .expected = 2 },
    .{ .name = "partial match end", .query = "hello", .reference = "help", .expected = 2 },
};
