const std = @import("std");
const print = std.debug.print;

var tmpnum: [10]u64 = undefined;
var setmem: [10]u64 = undefined;
pub fn separate_1000(num: u64) void {
    for (0..10) |i| {
        tmpnum[i] = 0;
        setmem[i] = 0;
    }
    var tmp: u64 = 0;
    var n: u64 = num;
    var i: u64 = 0;
    while (n > 0) : ({
        n /= 1000;
        i += 1;
    }) {
        tmpnum[i] = @mod(n, 1000);
    }
    var j: u64 = 0;
    while (i > 0) : ({
        i -= 1;
        j += 1;
    }) {
        tmp = tmpnum[i - 1];
        setmem[j] = tmp;
    }
    for (setmem, 0..10) |nums, index| {
        if (index < j - 1) {
            print("{},", .{nums});
        } else {
            print("{}", .{nums});
            break;
        }
    }
    print("\n", .{});
}

test "format test" {
    separate_1000(1234567);
}
