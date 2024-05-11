const std = @import("std");
const print = std.debug.print;
const N = 30;
pub const comments: []const u8 = "点灯している量で考えるデジタル時計";

const light = [_]u8{ 6, 2, 5, 5, 4, 5, 6, 3, 7, 6 };
fn check(num: usize) u32 {
    return light[num / 10] + light[@mod(num, 10)];
}

var lights: [60]u32 = undefined;
fn set_digs() void {
    for (0..60) |dig| {
        lights[dig] = check(dig);
    }
}

var segnums: [44]u32 = undefined;

pub fn checksegs() void {
    set_digs();
    for (0..44) |i| {
        segnums[i] = 0;
    }

    for (0..23 + 1) |hour| {
        for (0..59 + 1) |min| {
            for (0..59 + 1) |sec| {
                const seg = lights[hour] + lights[min] + lights[sec];
                segnums[@as(usize, @intCast(seg))] += 1;
            }
        }
    }
    print("In case of 30 segs turns on -> {}\n", .{segnums[30]});
}
