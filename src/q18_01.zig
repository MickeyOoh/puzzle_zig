const std = @import("std");
const print = std.debug.print;

pub const comments: []const u8 = "非常階段での脱出パターン";

const N = 16; // 段数

pub fn function() void {
    print("result: {}\n", .{cnt});
}

test "testing" {
    print("\nテスト:{s}\n", .{comments});
    function();
}
