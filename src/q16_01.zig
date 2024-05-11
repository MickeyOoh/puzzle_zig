const std = @import("std");
const print = std.debug.print;
const gcd = @import("mymath.zig").gcd;

pub const comments: []const u8 = "既約分数はいくつある?";

const N = 1_234_567;
//const N = 20;
const N_2 = @divFloor(N, 2);

pub fn function() void {
    var n: u32 = 0; //分子 numerator
    var d: u32 = 0; // 分母 denominator
    var cnt: u32 = 0;
    // 1. n + d = N
    // 2. n < d 分母の方が大きい 0 < x < 1.0
    // 3. n, d 共通の約数がない
    for (1..N_2 + 1) |ni| {
        n = @as(u32, @intCast(ni));
        d = N - n;
        // 最大公約数の求める mod(d, n) = r, mod(n, r) , rが0の時
        const v_gcd = gcd(d, n);
        if (v_gcd == 1) {
            cnt += 1;
            //print("{} / {}\n", .{ n, d });
        }
    }
    print("result: {}\n", .{cnt});
}

test "testing" {
    print("\nテスト:{s}\n", .{comments});
    function();
}
