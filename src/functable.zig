const q04 = @import("q04.zig");
const q05 = @import("q05.zig");
const q06 = @import("q06_02.zig");
const q07 = @import("q07_02.zig");
const q09 = @import("q09.zig");
const q10 = @import("q10.zig");
const q11 = @import("q11_02.zig");
const q12 = @import("q12.zig");
const q13 = @import("q13_01.zig");
const q14 = @import("q14_01.zig");
const q15 = @import("q15_01.zig");
const q16 = @import("q16_01.zig");
const q17 = @import("q17_01.zig");
const q18 = @import("q18_02.zig");
const q19 = @import("q19_02.zig");
const q20 = @import("q20_02.zig");

const FuncT = struct {
    name: []const u8, // パズル名で指定の引数
    func: *const fn () void, // 実行関数
    comment: []const u8, // 内容
};
pub const functable = [_]FuncT{
    FuncT{ .name = "q04", .func = q04.function, .comment = q04.comments },
    FuncT{ .name = "q05", .func = q05.function, .comment = q05.comments },
    FuncT{ .name = "q06", .func = q06.function, .comment = q06.comments },
    FuncT{ .name = "q07", .func = q07.function, .comment = q07.comments },
    FuncT{ .name = "q09", .func = q09.function, .comment = q09.comments },
    FuncT{ .name = "q10", .func = q10.function, .comment = q10.comments },
    FuncT{ .name = "q11", .func = q11.function, .comment = q11.comments },
    FuncT{ .name = "q12", .func = q12.function, .comment = q12.comments },
    FuncT{ .name = "q13", .func = q13.function, .comment = q13.comments },
    FuncT{ .name = "q14", .func = q14.function, .comment = q14.comments },
    FuncT{ .name = "q15", .func = q15.function, .comment = q15.comments },
    FuncT{ .name = "q16", .func = q16.function, .comment = q16.comments },
    FuncT{ .name = "q17", .func = q17.function, .comment = q17.comments },
    FuncT{ .name = "q18", .func = q18.function, .comment = q18.comments },
    FuncT{ .name = "q19", .func = q19.function, .comment = q19.comments },
    FuncT{ .name = "q20", .func = q20.function, .comment = q20.comments },
};
