const std = @import("std");
const print = std.debug.print;

pub const comments: []const u8 = "グループで乗るリフト";

const N = 5; // 5人
const M = 3; // 3人/リフト

var cnt: u32 = 0;

pub fn function() void {
    print("result: {}\n", .{cnt});
}

test "testing" {
    print("\nテスト:{s}\n", .{comments});
    function();
}
