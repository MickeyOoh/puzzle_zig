const std = @import("std");
const print = std.debug.print;
const power = std.math.pow;
const pr = @import("format.zig").print_comma;
const stdout = std.io.getStdOut().writer();

pub const comments: []const u8 = "非常階段での脱出パターン";

const N = 16; // 段数
//const N = 3; // 段数
var mem = [_]i64{0} ** power(i64, 2, N);
var N_bitmask: u32 = 0b1;
pub fn function() void {
    //print("mem.len: {}\n", .{mem.len});
    for (1..N) |_| {
        N_bitmask = (N_bitmask << 1) + 1;
    }
    mem[0] = 0;
    mem[1] = 1;
    const Num: u32 = power(u32, 2, N);
    var cnt: i64 = 0;
    for (1..Num) |n| {
        const num = @as(u32, @intCast(n));
        const dt = steps(num);
        cnt += dt;
        //print("{}-> {}\n", .{ n, dt });
    }
    print("result: {}段の時、{}\n", .{ N, cnt });
    _ = pr(cnt) catch 0;
}

fn steps(n: u32) i64 {
    if (mem[n] != 0) {
        return mem[n];
    }
    const none = ~n & N_bitmask;
    const movable = ((none << 1) + 1) & N_bitmask;
    //print("n: {b} -> none:{b},m:{b}, ", .{ n, none, movable });
    const s = n & (~movable & N_bitmask);
    const v = (n >> 1) & none;
    //print("s:{b} | v:{b}\n", .{ s, v });
    const moved = s | v;
    mem[n] = 1 + steps(moved);
    return mem[n];
}
test "testing" {
    print("\nテスト:{s}\n", .{comments});
    function();
}
