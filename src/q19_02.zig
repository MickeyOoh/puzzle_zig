const std = @import("std");
const expect = std.testing.expect;
const print = std.debug.print;
const pr = @import("format.zig").print_comma;

pub const comments: []const u8 = "バランスのよいカーテンフック";
pub const description =
    \\ ランナーが50個、フックの数が35個の時、掛け方が何通り
    \\ あるかを求める
;
//const RUNNER = 6; // num of Runner
//const HOOK = 4; // num of Hook
const RUNNER = 50; // num of Runner
const HOOK = 35; // num of Hook

const Keys = struct { nn: u32, rr: u32 };
pub fn function() void {
    print("内容:\n{s}\n", .{description});
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer {
        const deinit_status = gpa.deinit();
        if (deinit_status == .leak) expect(false) catch @panic("TEST FAIL");
    }
    var map = std.AutoHashMap(Keys, u64).init(allocator);
    defer map.deinit();

    //_ = map.put(key1, 1) catch @panic("map.put error");
    //_ = map.put(key2, 1) catch @panic("map.put error");

    const res = nCr(&map, HOOK - 1, RUNNER - HOOK);
    print("nCr: {} -> ", .{res});
    _ = pr(res) catch @panic("pr error");
}

fn nCr(map: anytype, n: u32, r: u32) u64 {
    const key = Keys{ .nn = n, .rr = r };
    const d = map.get(key);
    if (d) |dt| {
        return dt;
    }
    if ((r == 0) or (r == n)) return 1;
    const dd = nCr(map, n - 1, r - 1) + nCr(map, n - 1, r);
    _ = map.put(key, dd) catch @panic("map.put error");
    return dd;
}
test "testing" {
    print("\nテスト:{s}\n", .{comments});
    function();
}
