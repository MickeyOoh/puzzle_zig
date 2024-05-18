const std = @import("std");
const print = std.debug.print;

fn formatWithCommas(allocator: *std.mem.Allocator, value: i64) ![]u8 {
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

pub fn print_comma(num: i64) !void {
    var allocator = std.heap.page_allocator;

    const formattedValue = try formatWithCommas(&allocator, num);
    defer allocator.free(formattedValue);

    print("{s}\n", .{formattedValue});
}

test "format test" {
    //separate_1000(1234567);
    try print_comma(1234567);
}
