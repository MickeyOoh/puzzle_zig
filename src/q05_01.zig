const std = @import("std");
const print = std.debug.print;

var layer: [50][100]u32 = undefined;

const units = [_]u32{ 10000, 5000, 2000, 1000, 500, 100, 50, 10, 5, 1 };
var price_unit: [10]u32 = undefined;

pub fn count(price: u32) u32 {
    var pri: u32 = price;
    var num: u32 = 0;
    for (units, 0..) |unit, i| {
        var number = pri / unit;
        price_unit[i] = number;
        pri = (pri - number * unit);
        num += number;
    }
    //print("priceunit:{any} -", .{price_unit});
    return num;
}
pub fn pascal_triangle(args: u32) void {
    for (0..50) |i| {
        for (0..100) |j| {
            layer[i][j] = 0;
        }
    }

    layer[0][1] = 1;
    var m: u32 = 1;
    for (1..args + 1) |n| {
        m = 1;
        while (m <= n + 1) : (m += 1) {
            layer[n][m] = layer[n - 1][m - 1] + layer[n - 1][m];
        }
    }
    var total: u32 = 0;
    total = 0;
    for (0..args + 1) |n| {
        print("{} ->", .{n});
        for (1..n + 2) |i| {
            print("{} ", .{layer[n][i]});
            total += count(layer[n][i]);
        }
        print(" : {}\n", .{total});
    }
}

test "testing" {
    print("\n", .{});
    pascal_triangle(9);
}
