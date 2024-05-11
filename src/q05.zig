const std = @import("std");
const print = std.debug.print;

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

fn clear_array(array: []u64, len: usize) void {
    for (0..len) |i| {
        array[i] = 0;
    }
}

var row: [N + 2]u64 = undefined;

//pub fn pascal_triangle(args: u64) void {
pub fn pascal_triangle() void {
    const args: u64 = N;
    clear_array(&row, row.len);

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
}

test "testing" {
    print("\n", .{});
    pascal_triangle();
}
