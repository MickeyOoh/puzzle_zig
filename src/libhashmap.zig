const std = @import("std");
const print = std.debug.print;

pub fn gethashmap(keyt: type, valt: type) type {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    return std.AutoHashMap(keyt, valt).init(allocator);
}

test "testing" {
    const map = gethashmap(u64, u64);
    defer map.deinit();
    map.put(1234, 9);
    map.put(5678, 5);

    print("1234->{}, 5678->{}\n", .{ map.get(1234), map.get(5678) });
}
