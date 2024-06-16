const std = @import("std");
const print = std.debug.print;
const pr = @import("format.zig").print_comma;
const expect = std.testing.expect;

pub const comments: []const u8 = "酔っ払いの帰り道";
pub const description =
    \\ 駅の数が15個あり、乗車駅が3番目で降車駅が10番目の時、
    \\ 目的の駅までの移動パターンが何通りあるかを求めて下さい。
;

//const N = 5; // 全部の駅数
//const START = 2; // 乗車駅
//const GOAL = 3; //  降車駅
const N = 15; // 全部の駅数
const START = 3; // 乗車駅
const GOAL = 10; //  降車駅
var result: u64 = 0;
const Keys = struct {
    used: [N]bool,
    pos: u8,
};
pub fn function() void {
    print("内容:\n{s}\n", .{description});
    var used = [_]bool{false} ** N;
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer {
        const deinit_status = gpa.deinit();
        if (deinit_status == .leak) expect(false) catch @panic("Memory leak");
    }
    var map = std.AutoHashMap(Keys, u64).init(allocator);
    defer map.deinit();

    result = search(&map, &used, START);
    print("result: {} -> ", .{result});
    _ = pr(result) catch 0;

    // 方向によりカウントする
    if (START == GOAL) {
        result = 1;
    } else if (START < GOAL) {
        result = count(GOAL - 2, N - GOAL);
    } else {
        result = count(N - GOAL - 1, GOAL - 1);
    }
    print("result: {} -> ", .{result});
    _ = pr(result) catch 0;
}
// used, pos: 1番目からN番目 注意) 0からではない
fn search(map: anytype, pused: *[N]bool, pos: u8) u64 {
    const key = Keys{ .used = pused.*, .pos = pos };
    // 既にカウントした分は新たに計算せず、return
    const dt = map.get(key);
    if (dt) |d| {
        return d;
    }
    // Goalに到着した時 1回をreturn
    if (pos == GOAL) {
        return 1;
    }
    var cnt: u64 = 0;
    pused[pos - 1] = true;

    if (pos < GOAL) {
        for (GOAL..N + 1) |i| {
            if (pused[i - 1] == false) {
                cnt += search(map, pused, @as(u8, @intCast(i)));
            }
        }
    } else {
        for (1..GOAL + 1) |i| {
            if (pused[i - 1] == false) {
                cnt += search(map, pused, @as(u8, @intCast(i)));
            }
        }
    }
    pused[pos - 1] = false;

    _ = map.put(Keys{ .used = pused.*, .pos = pos }, cnt) catch 0;
    return cnt;
}

fn count(bw: u8, fw: u8) u64 { // bw backward fw: foreward
    if (fw == 0) {
        return 1;
    }
    return (1 + fw * count(fw - 1, bw));
}

test "testing" {
    print("\nテスト:{s}\n", .{comments});
    function();
}
