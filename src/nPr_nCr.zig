const std = @import("std");
const assert = std.debug.assert;
const print = std.debug.print;

pub fn nPr(n: u64, r: u64) u64 {
    var result: u64 = 1;
    //if (r == 0) return 1;
    for (0..r) |i| {
        result *= (n - i);
    }
    //print("{}P{} = {}\n", .{ n, r, result });
    return result;
}
// nCr = nPr/r! = n!/r!*(n-r)!

pub fn nCr(n: u64, r: u64) u64 {
    var result: u64 = 1;
    result = nPr(n, r) / nPr(r, r);
    return result;
}
test "Permutation test" {
    assert(nPr(5, 3) == 60);
    assert(nCr(5, 3) == 10);
}
