const std = @import("std");
const print = std.debug.print;

pub const comments: []const u8 = "現地で使いやすい両替";

const N = 45678; // 両替する金額

const coins = [_]u32{ 10000, 5000, 2000, 1000, 500, 100, 50, 10, 5, 1 };

pub fn function() void {
    var money: u32 = N;
    var num: [10]u32 = undefined;
    for (&num) |*pnum| {
        pnum.* = 1;
    }
    for (coins) |m| {
        money -= m;
    }
    print("remain: {}\n", .{money});
    for (coins, 0..) |coin, i| {
        const n: u32 = money / coin;
        num[i] += n;
        money -= coin * n;
    }
    var total: u32 = 0;
    var m_total: u32 = 0;
    for (num, coins) |n, m| {
        total += n;
        m_total += n * m;
        print("coin:{}, no:{}\n", .{ m, n });
    }
    print("total: {} m: {}\n", .{ total, m_total });
}
test "testing" {
    function();
}
