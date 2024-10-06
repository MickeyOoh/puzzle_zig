const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;

pub fn mngHash(
    comptime K: type,
    comptime V: type,
) type {
    return struct {
        allocator: std.mem.Allocator,
        gpa: std.heap.GeneralPurposeAllocator(.{}),
        map: std.AutoHashMap(K, V),
        const Self = @This();
        var initiate: bool = false;
        pub fn init() Self {
            var gpa = std.heap.GeneralPurposeAllocator(.{}){};
            const allocator = gpa.allocator();
            const map = std.AutoHashMap(K, V).init(allocator);
            return .{ .allocator = allocator, .gpa = gpa, .map = map };
        }
        pub fn deeinit(self: *Self) void {
            self.map.deinit();
            const deinit_status = self.gpa.deinit();
            //fail test; can't try in defer as defer is executed after we return
            if (deinit_status == .leak) expect(false) catch @panic("TEST FAIL");
        }
        pub fn putx(self: *Self, key: K, val: V) void {
            //Self.mutex.lock();
            //defer Self.mutex.unlock();
            //_ = key;
            //_ = val;
            print("self.map:{any}\n", .{self.map});
            _ = self.map.put(key, val) catch 0;
        }
        pub fn getx(self: *Self, key: K) ?V {
            //Self.mutex.lock();
            //defer Self.mutex.unlock();
            return self.map.get(key);
        }
    };
}
const mngH = mngHash(u64, u64);

test "testing" {
    var map = mngH.init();
    print("typeof(m): {any}\n", .{@TypeOf(map)});
    map.putx(1234, 4321);
    //const ret = map.get(1234);
    //print("ret: {any}\n", .{ret});
    map.deeinit();
}
