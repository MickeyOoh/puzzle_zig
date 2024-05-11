const std = @import("std");
const print = std.debug.print;

pub const comments: []const u8 = "幅優先の二分木を深さ優先探索";

pub fn function() void {
    const M, const N = .{ 3000, 2500 };
    //const M, const N = .{ 10, 8 };
    var pre: u32, var now: u32, var n: u32 = .{ 0, 1, N };
    //print("\n0:{} {} {}\n", .{ pre, now, n });
    while (n > 1) {
        if ((pre * 2 == now) or ((pre * 2 + 1) == now)) {
            // 下に降りてきた時
            if (now * 2 <= M) {
                // まだ左下にノードが残っていれば左下
                pre, now, n = .{ now, now * 2, n - 1 };
                //print("1:{} {} {}\n", .{ pre, now, n });
            } else {
                // ノードがなければ上に戻る
                pre, now = .{ now, now / 2 };
                //print("2:{} {} {}\n", .{ pre, now, n });
            }
        } else {
            if (@mod(pre, 2) == 0) {
                // 左下から　戻ってきた時
                if ((now * 2 + 1) <= M) {
                    // 右下にノードが残ってれば右下
                    pre, now, n = .{ now, now * 2 + 1, n - 1 };
                    //print("3:{} {} {}\n", .{ pre, now, n });
                } else {
                    // ノードがなければ上に戻る
                    pre, now = .{ now, now / 2 };
                    //print("4:{} {} {}\n", .{ pre, now, n });
                }
            } else {
                // 右下から戻ってきた時は上の戻る
                pre, now = .{ now, now / 2 };
                //print("5:{} {} {}\n", .{ pre, now, n });
            }
        }
    }
    print("result: {}\n", .{now});
}

test "testing" {
    function();
}
