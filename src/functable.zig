const std = @import("std");
const print = std.debug.print;
const q04 = @import("q04.zig");
const q05 = @import("q05.zig");
const q06 = @import("q06_02.zig");
const q07 = @import("q07_02.zig");
const q09 = @import("q09.zig");
const q10 = @import("q10.zig");

const FuncT = struct {
    name: []const u8, // パズル名で指定の引数
    func: *const fn () void, // 実行関数
    comment: []const u8, // 内容
};
pub const functable = [_]FuncT{
    FuncT{ .name = "q04", .func = q04.checksegs, .comment = "点灯している量で考えるデジタル時計" },
    FuncT{ .name = "q05", .func = q05.pascal_triangle, .comment = "枚数で考えるパスカルの三角形" },
    FuncT{ .name = "q06", .func = q06.make_square, .comment = q06.comments },
    FuncT{ .name = "q07", .func = q07.redo_order, .comment = q07.comments },
    FuncT{ .name = "q09", .func = q09.narcissistic_number, .comment = q09.comments },
    FuncT{ .name = "q10", .func = q10.function, .comment = q10.comments },
};
