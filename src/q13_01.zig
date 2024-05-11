const std = @import("std");
const print = std.debug.print;
// Cの関数を宣言
//const permutation = extern "C" fn next_permutation(first: usize, last: usize, v: []c_int) bool;
//extern "C" fn next_permutation(first: usize, last: usize, v: [*]i8) bool;
const mymath = @import("mymath.zig");
const next_permutation = mymath.next_permutation;
const reverse = mymath.reverse;
// 左に1がある並びを生成
pub const comments: []const u8 = "並べ替えの繰り返し2";
const M = 9; // card no. 1..M+1
const N = 5;
var v: [M]u8 = undefined;
pub fn function() void {
    var cnt: u8 = 0;
    //const allocator = std.heap.page_allocator;
    //const memory = allocator.alloc(u8, 100);
    //defer allocator.free(memory);
    // set num into v[]
    for (&v, 1..) |*item, idx| {
        item.* = @as(u8, @intCast(idx));
    }
    while (true) {
        //print(" -> {any}\n", .{v});
        cnt = 0;
        switching(&v, 0);
        if (next_permutation(1, M, &v) == false) {
            break;
        }
    }
    print("total: {}\n", .{total});
}
var total: u32 = 0;
fn switching(va: []u8, scale: u8) void {
    if (scale >= N) {
        total += 1;
        //print("\n", .{});
        return;
    }
    var vva: [M]u8 = undefined;
    for (1..M) |i| {
        for (va, 0..) |*ptr, n| {
            vva[n] = ptr.*;
        }
        if (vva[i] == i + 1) {
            reverse(0, i + 1, &vva);
            //print("{}->vva({}): {any}\n", .{ i, scale + 1, vva });
            switching(&vva, scale + 1);
        }
    }
}
//pub fn main() void {
//    function();
//}
test "testing" {
    function();
}
