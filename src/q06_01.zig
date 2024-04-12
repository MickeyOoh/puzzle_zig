const std = @import("std");
const print = std.debug.print;

const W = 1000;
const N = 20;

fn cut(w: u64, h: u64) u64 {
    var q: u64 = 0;
    var r: u64 = 0;
    var wt: u64 = 0;
    var ht: u64 = 0;
    if (w == h) return 1;
    if (w > h) {
        wt = h;
        ht = w;
    } else {
        wt = w;
        ht = h;
    }
    q = ht / wt;
    r = @mod(ht, wt);
    if (r > 0) {
        q += cut(wt, r);
    }
    //print("w:{} h:{}-> q:{} r:{}\n", .{ w, h, ret, r });
    return q;
}

pub fn make_square() void {
    var cnt: u64 = 0;
    for (1..W + 1) |i| {
        for (i..W + 1) |j| {
            if (cut(i, j) == N) {
                cnt += 1;
            }
        }
    }
    print("cnt: {}\n", .{cnt});
}

test "make square from rectangle" {
    make_square();
}
