const std = @import("std");
const print = std.debug.print;
const pr = @import("format.zig").print_comma;
pub const comments: []const u8 = "枚数で考えるパスカルの三角形";

const N = 45;

fn count(n: u64) u64 {
    var price: u64 = n;
    const coin = [_]u64{ 10000, 5000, 2000, 1000, 500, 100, 50, 10, 5, 1 };
    var result: u64 = 0;
    for (coin) |c| {
        const cnt = price / c;
        price -= (c * cnt);
        result += cnt;
    }
    //print("{} -> {}\n", .{ n, result });
    return result;
}

var row = [_]u64{0} ** (N + 2);

pub fn pascal_triangle() void {
    const args: u64 = N;

    row[0] = 1;
    for (1..args + 1) |i| {
        var j = i + 1;
        while (j >= 1) : (j -= 1) {
            row[j] += row[j - 1];
        }
        //print("i:{}, j:{} -> ", .{ i, j });
        //for (0..i + 1) |index| {
        //    print("{} ", .{row[index]});
        //}
        //print("\n", .{});
    }
    var total: u64 = 0;
    for (0..args + 2) |i| {
        total += count(row[i]);
    }
    print("n: {}-coins:{}\n", .{ args, total });
    _ = pr(total) catch 0;
}

pub fn function() void {
    pascal_triangle();
}
test "testing" {
    print("\n", .{});
    pascal_triangle();
}
