const std = @import("std");

const TestCase = struct {
    s1: []const u8,
    s2: []const u8,
    expected: usize,
};

const test_cases = [_]TestCase{
    .{ .s1 = "", .s2 = "", .expected = 0 },
    .{ .s1 = "", .s2 = "a", .expected = 1 },
    .{ .s1 = "a", .s2 = "", .expected = 1 },
    .{ .s1 = "same", .s2 = "same", .expected = 0 },
    .{ .s1 = "cat", .s2 = "cats", .expected = 1 },
    .{ .s1 = "cats", .s2 = "cat", .expected = 1 },
    .{ .s1 = "cat", .s2 = "bat", .expected = 1 },
    .{ .s1 = "abc", .s2 = "abcdef", .expected = 3 },
    .{ .s1 = "abcdef", .s2 = "abc", .expected = 3 },
    .{ .s1 = "abc", .s2 = "def", .expected = 3 },
    .{ .s1 = "kitten", .s2 = "sitting", .expected = 3 },
    .{ .s1 = "saturday", .s2 = "sunday", .expected = 3 },
    .{ .s1 = "horse", .s2 = "ros", .expected = 3 },
    .{ .s1 = "intention", .s2 = "execution", .expected = 5 },
    .{ .s1 = "algorithm", .s2 = "altruistic", .expected = 6 },
    .{ .s1 = "a", .s2 = "very long string", .expected = 16 },
    .{ .s1 = "aaaa", .s2 = "bbbb", .expected = 4 },
    .{ .s1 = "abc", .s2 = "acb", .expected = 2 },
    .{ .s1 = "hello", .s2 = "help", .expected = 2 },
};