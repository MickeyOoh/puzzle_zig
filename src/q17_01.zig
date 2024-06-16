const std = @import("std");
const print = std.debug.print;
const pr = @import("format.zig").print_comma;

pub const comments: []const u8 = "グループで乗るリフト";

//const N = 5; // 5人
//const M = 3; // 3人/リフト
const N = 32; // 5人
const M = 6; // 3人/リフト
var lifts = [_]usize{0} ** (N + 1);
var mem = [_]i64{0} ** (N + 1);
fn board(remain: usize, scale: usize) i64 {
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
    var cnt: i64 = 0;
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
    mem[0] = 1;
    mem[1] = 1;
    const cnt = board(N, 0);
    print("result: {}\n", .{cnt});
    _ = pr(cnt) catch 0;
}

test "testing" {
    print("\nテスト:{s}\n", .{comments});
    function();
}
