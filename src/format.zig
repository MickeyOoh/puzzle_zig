const std = @import("std");
const print = std.debug.print;

const TypeError = error{
    InvalidType,
};

fn formatWithCommas(allocator: *std.mem.Allocator, value: u64) ![]u8 {
    const buffer = std.fmt.allocPrint(allocator.*, "{}", .{value}) catch return error.OutOfMemory;
    const len = buffer.len;
    var result = try allocator.alloc(u8, len + len / 3);

    var srcIndex: usize = 0;
    var dstIndex: usize = 0;
    var count: usize = len % 3;

    if (count == 0 and len > 0) {
        count = 3;
    }

    while (srcIndex < len) {
        if (count == 0) {
            result[dstIndex] = ','; // Insert comma
            dstIndex += 1;
            count = 3;
        }

        result[dstIndex] = buffer[srcIndex];
        srcIndex += 1;
        dstIndex += 1;
        count -= 1;
    }

    return result;
}
fn fmtWithCommas(buffsrc: []u8, outbuff: []u8) []u8 {
    const len = buffsrc.len;
    var srcIndex: usize = 0;
    var dstIndex: usize = 0;
    var count: usize = len % 3;

    if (count == 0 and len > 0) {
        count = 3;
    }
    while (srcIndex < len) {
        if (count == 0) {
            outbuff[dstIndex] = ','; // Insert comma
            dstIndex += 1;
            count = 3;
        }

        outbuff[dstIndex] = buffsrc[srcIndex];
        srcIndex += 1;
        dstIndex += 1;
        count -= 1;
    }

    return outbuff;
}

pub fn print_comma(num: anytype) !void {
    const n = switch (@TypeOf(num)) {
        u64 => num,
        i64 => @as(u64, @intCast(num)),
        u32, i32, u16, i16 => @as(u64, @intCast(num)),
        else => TypeError.InvalidType,
    };
    var allocator = std.heap.page_allocator;
    const formattedValue = try formatWithCommas(&allocator, n);
    defer allocator.free(formattedValue);

    print("{s}\n", .{formattedValue});
}
pub fn print_comma_new(comptime T: type, num: T) !void {
    const n = switch (@TypeOf(num)) {
        u64 => num,
        i64 => @as(u64, @intCast(num)),
        u32, i32, u16, i16 => @as(u64, @intCast(num)),
        else => TypeError.InvalidType,
    };
    var allocator = std.heap.page_allocator;
    const buffer = std.fmt.allocPrint(allocator, "{}", .{n}) catch return error.OutOfMemory;
    const len = buffer.len;
    const outbuff = try allocator.alloc(u8, len + len / 3);
    defer allocator.free(outbuff);
    fmtWithCommas(buffer, outbuff);
    //const formattedValue = try formatWithCommas(&allocator, n);
    //defer allocator.free(formattedValue);

    print("{s}\n", .{outbuff});
}

test "format test" {
    const xi32: i32 = 1234567;
    const xu64: u64 = 12345678;
    try print_comma(xi32);
    try print_comma(xu64);
}
