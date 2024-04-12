const std = @import("std");
const print = std.debug.print;
const nPr = @import("nPr_nCr.zig").nPr;
const nCr = @import("nPr_nCr.zig").nCr;
const pr = @import("format.zig");

pub const comments: []const u8 = "ファイルの順番を元どおりに戻したい!";
const N = 15;
var cnt: [N]u64 = undefined;

pub fn redo_order() void {
    var total: u64 = 0;
    for (0..N) |i| {
        cnt[i] = 0;
    }
    cnt[0] = 1;
    cnt[1] = 0;
    for (2..N + 1) |i| {
        for (0..i - 1) |j| {
            cnt[i - j - 1] = cnt[i - j - 2] * i;
        }
        cnt[1] = i - 1;
    }
    for (0..N) |i| {
        total += cnt[i] * i;
    }
    print("answer({}): {}\n", .{ N, total });
    pr.separate_1000(total);
    //const formattedNumber = std.math.formatU64(total, .{ .thousands_separator = ',' });
    //print("answer: {}\n", .{formattedNumber});
}

test "Testing" {
    redo_order();
}
