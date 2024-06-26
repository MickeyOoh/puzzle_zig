const std = @import("std");
const print = std.debug.print;
const power = std.math.pow;
const pr = @import("format.zig").print_comma;
const stdout = std.io.getStdOut().writer();

pub const comments: []const u8 = "非常階段での脱出パターン";

const N = 16; // 段数
//const N = 3; // 段数
var N_bitmask: u32 = 0b1;
pub fn function() void {
    for (1..N) |_| {
        N_bitmask = (N_bitmask << 1) + 1;
    }
    //print("N_bitmask:{b}\n", .{N_bitmask});

    const Num: u32 = power(u32, 2, N);
    var cnt: i64 = 0;
    for (1..Num) |n| {
        const num = @as(u32, @intCast(n));
        const dt = count_time(num);
        cnt += dt;
        //print("{}-> {}\n", .{ n, dt });
    }
    print("result: {}段の時、{}\n", .{ N, cnt });
    _ = pr(cnt) catch 0;
}

fn count_time(num: u32) i64 {
    var n = num;
    var cnt: i64 = 0;
    while (n > 0) {
        cnt += 1;

        const none = ~n & N_bitmask; // ビットの反転 -> 移動できるビット
        const movable = ((none << 1) + 1) & N_bitmask; // 移動できるビット
        //print("n: {b} -> none:{b},m:{b}, ", .{ n, none, movable });
        const s = n & (~movable & N_bitmask); // 移動しない保持するビット
        const v = (n >> 1) & none; // 移動した後のビットで移動できたビット
        //print("s:{b} | v:{b}\n", .{ s, v });
        n = s | v;
    }
    return cnt;
}
test "testing" {
    print("\nテスト:{s}\n", .{comments});
    function();
}
