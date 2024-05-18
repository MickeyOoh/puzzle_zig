const std = @import("std");
const print = std.debug.print;
const pr = @import("format.zig").print_comma;

pub const comments: []const u8 = "オリンピックの開催都市投票";

const N: u64 = 7; // 都市数

var cnt: u64 = 0;

pub fn function() void {
    const ans: u64 = vote(N);
    print("{} -> {}\n", .{ N, ans });
    const ans_cast: i64 = @as(i64, @intCast(ans));
    _ = pr(ans_cast) catch 0;
}

fn vote(n: u64) u64 {
    if (n <= 2) {
        return 1; //
    }
    cnt = 1; // 1つが過半数
    cnt += vote(n - 1); // 1つが脱落
    for (2..n) |i| { // 下位i個が並んだ時
        // 下位i個から1つが選ばれ、残ったn - 1個で投票
        cnt += vote(i) * vote(n - 1);
    }
    return cnt;
}
test "testing" {
    function();
}
