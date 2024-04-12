const std = @import("std");
const print = std.debug.print;

const N = 1000; //
const AIM: u32 = 20;
pub fn make_square() void {
    var count: u32 = 0;
    for (1..N + 1) |height| {
        for (height..N + 1) |width| {
            if (check(AIM, @as(u32, @intCast(width)), @as(u32, @intCast(height)))) {
                count += 1;
            }
        }
    }
    print("case: {}\n", .{count});
}
fn check(aim: u32, width: u32, height: u32) bool {
    //print("origin {} x {}\n", .{ width, height });
    var ret: bool = false;
    var case: u32 = 0;
    var w: u32 = width;
    var h: u32 = height;
    while (case < aim + 1) {
        if (w == h) {
            case += 1;
            break;
        }
        if (w > h) {
            w = w - h;
        } else {
            h = h - w;
        }
        //print("w:{} x h:{}\n", .{ w, h });
        case += 1;
    }
    if (case == aim) {
        //print("== found {}: {} x {} ==\n", .{ aim, width, height });
        ret = true;
    }
    return ret;
}

test "長方形から正方形を作る" {
    make_square();
}
