const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;

//const K: type = u64;
//const V: type = u64;
var allocator: std.mem.Allocator = undefined;
var gpa: std.heap.GeneralPurposeAllocator(.{}) = undefined;
const MT: type = std.AutoHashMap(K, V);
var map: MT = undefined;

pub fn hashfnc(KT: type, VT: type) type {
    K: type,
    V: type,
    map: std.AutoHashMap(KT, VT),
    pub fn init() MT {
        gpa = std.heap.GeneralPurposeAllocator(.{}){};
        allocator = gpa.allocator();
        map = std.AutoHashMap(K, V).init(allocator);
        return map;
    }
}
pub fn init() MT {
    gpa = std.heap.GeneralPurposeAllocator(.{}){};
    allocator = gpa.allocator();
    map = std.AutoHashMap(K, V).init(allocator);
    return map;
}

pub fn deinit() void {
    map.deinit();
    const deinit_status = gpa.deinit();
    //fail test; can't try in defer as defer is executed after we return
    if (deinit_status == .leak) expect(false) catch @panic("TEST FAIL");
}
pub fn put(key: K, val: V) void {
    _ = map.put(key, val) catch 0;
}
pub fn get(key: K) ?V {
    return map.get(key);
}

test "testing" {
    map = init();
    print("typeof(m): {any}\n", .{@TypeOf(map)});
    defer deinit();
    put(1234, 4321);
    const ret = get(1234);
    print("ret: {any}\n", .{ret});
}
