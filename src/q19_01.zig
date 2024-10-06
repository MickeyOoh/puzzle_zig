const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;
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
const Keys = struct {
    runner: u8,
    hook: u8,
};

//var map: anytype = undefined;
const key1 = Keys{ .runner = 2, .hook = 2 };
const key2 = Keys{ .runner = 3, .hook = 2 };

var map: std.AutoHashMap(Keys, u64) = undefined;

pub fn function() void {
    print("内容:\n{s}\n", .{description});
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer {
        const deinit_status = gpa.deinit();
        //fail test; can't try in defer as defer is executed after we return
        if (deinit_status == .leak) expect(false) catch @panic("TEST FAIL");
    }
    map = std.AutoHashMap(Keys, u64).init(allocator);
    defer map.deinit();

    print("map:{any}\n", .{map});
    _ = map.put(key1, 1) catch 0;
    putcnt += 1;
    _ = map.put(key2, 1) catch 0;
    putcnt += 1;
    print("map.capacity() -> {}\n", .{map.capacity()});
    //const result = search(&map, RUNNER, HOOK);
    const result = search(RUNNER, HOOK);
    print("result: {} ->", .{result});
    _ = pr(result) catch 0;
}
var putcnt: u64 = 0;
//fn search(map: anytype, runner: u8, hook: u8) u64 {
fn search(runner: u8, hook: u8) u64 {
    const key = Keys{ .runner = runner, .hook = hook };
    var dt = map.get(key);
    if (dt) |d| {
        //print("exist: {any} : {}\n", .{ key, d });
        return d;
    } else {
        //print("first: {any} : {any}\n", .{ key, dt });
    }
    if (hook <= 1) {
        return 0;
    }
    if (runner < hook) {
        return 0;
    }
    var cnt: u64 = 0;
    //cnt += search(map, runner - 1, hook - 1);
    cnt += search(runner - 1, hook - 1);
    // 一つ飛ばしてフックをセット
    //cnt += search(map, runner - 2, hook - 1);
    cnt += search(runner - 2, hook - 1);

    _ = map.put(key, cnt) catch |err| {
        print("map.put error:{?}\n", .{err});
    };
    putcnt += 1;
    dt = map.get(key);
    _ = expect(dt == cnt) catch 0;
    return cnt;
}

test "testing" {
    print("\nテスト:{s}\n", .{comments});
    function();
}
