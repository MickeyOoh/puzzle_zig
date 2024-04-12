const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    var a = [_]u64{ 1, 2, 3 };
    var b = [_]u64{ 4, 5 };

    var c = a ++ b;

    print("a:{any}, b:{any}, c:{any}", .{ a, b, c });

    var d0 = [_]u64{0};
    var d = d0 ** 15;
    print("d: {any}\n", .{d});
    for (0..3) |i| {
        for (2..4) |j| {
            var aa = std.math.pow(u64, a[i], j);
            print("aa({})->{}**{} -> {}\n", .{ i, a[i], j, aa });
        }
    }
}
