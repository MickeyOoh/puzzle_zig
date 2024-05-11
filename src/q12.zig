const std = @import("std");
const print = std.debug.print;
const power = std.math.pow;

pub const comments: []const u8 = "円周率に近似できる分数";

const N = 11; // 桁
// 指定した桁数の円周率を整数で取得
const pi = 314_159_265_358;
const Pow = power(u64, 10, N);

pub fn function() void {
    var q: u64 = 1;
    while (true) {
        const low: u64 = @divFloor(q * pi, Pow);
        const high: u64 = @divFloor(q * (pi + 1), Pow);
        if (low != high) {
            if (@mod(q * (pi + 1), Pow) > 0) {
                // 余りが0より大きいとき
                print("q: {}\n", .{q});
                break;
            }
        }
        q += 1;
    }
}
test "testing" {
    function();
}
