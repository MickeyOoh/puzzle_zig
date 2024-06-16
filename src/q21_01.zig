const std = @import("std");
const print = std.debug.print;
const pr = @import("format.zig").print_comma;
const expect = std.testing.expect;

pub const comments: []const u8 = "本の読み方は何通り?";
pub const description =
    \\ 本が180ページ、返却までの日数が14日の時、14日以内で読み終わるパターンが 
    \\ 全部で何通りあるかを求めて下さい 
;

//const N = 5; // 全部の駅数
//const START = 2; // 乗車駅
//const GOAL = 3; //  降車駅
const N = 15; // 全部の駅数
const START = 3; // 乗車駅
const GOAL = 10; //  降車駅
pub fn function() void {
    print("内容:\n{s}\n", .{description});
}

test "testing" {
    print("\nテスト:{s}\n", .{comments});
    function();
}
