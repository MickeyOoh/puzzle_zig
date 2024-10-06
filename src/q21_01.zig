const std = @import("std");
const print = std.debug.print;
const pr = @import("format.zig").print_comma;
const expect = std.testing.expect;

pub const comments: []const u8 = "本の読み方は何通り?";
pub const description =
    \\ 本が180ページ、返却までの日数が14日の時、14日以内で読み終わるパターンが 
    \\ 全部で何通りあるかを求めて下さい 
;

//const PAGES = 180; // ページ数
//const DAYS = 14; // 何日以内に読み終える
const PAGES = 100; // ページ数
const DAYS = 3; // 何日以内に読み終える
pub fn function() void {
    print("内容:\n{s}\n", .{description});
    var count: u64 = 0;
}
var eachpage = [D]u8{0} ** D;
fn count(page: u32, prev: u32, days: u32) u64 {}
test "testing" {
    print("\nテスト:{s}\n", .{comments});
    function();
}
