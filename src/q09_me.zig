const std = @import("std");
const print = std.debug.print;
const power = std.math.pow;
pub const comments: []const u8 = "ナルシシストな8進数";

var orders: [10]u64 = undefined;
pub fn octal() void {
    for (0..10) |i| {
        orders[i] = 0;
    }
    var cnt: u64 = 0;
    for (8..80000) |decimal| {
        var ii: usize = 0;
        var dec = decimal;
        while (dec > 0) : (dec /= 8) {
            orders[ii] = @mod(dec, 8);
            ii += 1;
        }
        var total: u64 = 0;
        var pre_total: u64 = 0;
        for (2..4) |pow| {
            total = 0;
            for (0..ii) |i| {
                var tmp: u64 = power(u64, orders[i], pow);
                total += tmp;
                //if (decimal < 20) {
                //    print("orders[{}]-{} -> {}\n", .{ i, orders[i], tmp });
                //}
            }
            if (decimal == total) {
                cnt += 1;
                print("{}:{},pow:{} - {any}\n", .{ cnt, ii, pow, orders });
                break;
            } else if (decimal < total) {
                break;
            } else {
                if (pre_total == total) {
                    //print("pre == total: {}\n", .{total});
                    break;
                } else {
                    //print("pre:{} != total:{}\n", .{ pre_total, total });
                    pre_total = total;
                    continue;
                }
            }
        }
        if (cnt > 9) {
            break;
        }
    }
}

test "Nalcist 8 number" {
    print("\n", .{});
    octal();
}
