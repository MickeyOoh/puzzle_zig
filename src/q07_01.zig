const std = @import("std");
const print = std.debug.print;
const nPr = @import("nPr_nCr.zig").nPr;
const nCr = @import("nPr_nCr.zig").nCr;
const assert = std.debug.assert;

pub const comments: []const u8 = "ファイルの順番を元どおりに戻したい!";
const N = 5;

pub fn redo_order() void {
    var cnt: u64 = 0;
    for (1..N) |i| {
        cnt += (i * (N - i) * nPr(N, i - 1));
    }
    print("answer({}): {}\n", .{ N, cnt });
}

test "Testing" {
    assert(nPr(5, 3) == 60);
    assert(nCr(5, 3) == 10);
    redo_order();
}
