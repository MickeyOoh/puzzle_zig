const std = @import("std");
const print = std.debug.print;
const pr = @import("format.zig").print_comma;

pub const comments: []const u8 = "グループで乗るリフト";

//const N = 5; // 5人
//const M = 3; // 3人/リフト
const N = 32; // 5人
const M = 6; // 3人/リフト
var lifts: [N + 1]usize = undefined;
var mem: [N + 1]usize = undefined;
fn board(remain: usize, scale: usize) usize {
    //
    //if (remain < 0) return 0;
    //if (remain == 0) {
    //    no += 1;
    //    print("{} -> {any}\n", .{ no, lifts });
    //    return 1;
    //}
    if (mem[remain] > 0) {
        return mem[remain];
    }
    var cnt: u64 = 0;
    for (1..M + 1) |i| {
        lifts[scale] = i;
        if (remain >= i) {
            cnt += board(remain - i, scale + 1);
            lifts[scale + 1] = 0;
        }
        //print("remain: {}, lift: {}, cnt: {}\n", .{ remain, i, cnt });
    }
    mem[remain] = cnt;
    return cnt;
}
pub fn function() void {
    for (0..lifts.len) |i| {
        lifts[i] = 0;
        mem[i] = 0;
    }
    mem[0] = 1;
    mem[1] = 1;
    //print("iifts: {any}\n", .{lifts});
    const cnt = board(N, 0);
    print("result: {}\n", .{cnt});
    _ = pr(@as(i64, @intCast(cnt))) catch 0;
}

test "testing" {
    print("\nテスト:{s}\n", .{comments});
    function();
}
