const std = @import("std");
const print = std.debug.print;

const digsegs = [_]u8{ 6, 2, 5, 5, 4, 5, 6, 3, 7, 6 };

fn countsegs(hour: u8, min: u8, sec: u8) u8 {
    var segnum: u8 = 0;
    var timedigs = [_]u8{ hour / 10, @mod(hour, 10), min / 10, @mod(min, 10), sec / 10, @mod(sec, 10) };
    for (timedigs) |dig| {
        segnum += digsegs[dig];
    }
    return segnum;
}
var segnums: [44]u32 = undefined;

pub fn checksegs() void {
    for (0..44) |i| {
        segnums[i] = 0;
    }

    for (0..23 + 1) |hour| {
        for (0..59 + 1) |min| {
            for (0..59 + 1) |sec| {
                var seg = countsegs(@as(u8, @intCast(hour)), @as(u8, @intCast(min)), @as(u8, @intCast(sec)));
                segnums[@as(usize, @intCast(seg))] += 1;
            }
        }
    }
    print("30 segs turns off -> {}\n", .{segnums[30]});
}
