const std = @import("std");
const print = std.debug.print;
pub const comments: []const u8 = "長方形から正方形を作る";
const W = 1000;
const N = 20;
fn cut(w: i32, h: i32, n: i32) bool {
    var q: i32 = 0;
    var r: i32 = 0;
    var wt: i32 = 0;
    var ht: i32 = 0;
    //var wt, var ht = .{0, 0};
    if (w == h) {
        return (n == 0);
    }
    if (w > h) {
        wt = h;
        ht = w;
    } else {
        wt = w;
        ht = h;
    }
    q = @divFloor(ht, wt);
    r = @mod(ht, wt);
    if (((n - q) < 0) or (r == 0)) {
        return ((n - q) == 0);
    } else {
        return cut(wt, r, n - q);
    }
}

pub fn function() void {
    var cnt: i32 = 0;
    for (1..W + 1) |i| {
        for (i..W + 1) |j| {
            if (cut(@as(i32, @intCast(i)), @as(i32, @intCast(j)), N)) {
                cnt += 1;
            }
        }
    }
    print("cnt: {}\n", .{cnt});
}

test "make square from rectangle" {
    function();
}
