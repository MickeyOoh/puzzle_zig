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
// 切り上げ割り算
pub fn dive_ceil(x: u64, y: u64) u64 {
    return (x + y - 1) / y;
}

pub fn swap(a: *u8, b: *u8) void {
    const tmp: u8 = b.*;
    b.* = a.*;
    a.* = tmp;
}

pub fn reverse(first: usize, last: usize, v: []u8) void {
    var fir: usize = first;
    var las: usize = last;
    while (fir != las and fir != (las - 1)) : (fir += 1) {
        las -= 1;
        swap(&v[fir], &v[las]);
    }
}

pub fn next_permutation(first: usize, last: usize, v: []u8) bool {
    var i: usize = 0;
    var j: usize = 0;
    var k: usize = 0;
    //var i: usize, var j: usize, var k: usize = .{ 0, 0, 0 };
    if (first == last) {
        return false;
    }
    if (first + 1 == last) {
        return false;
    }
    i = last - 1;
    while (true) {
        j = i;
        i -= 1;
        if (v[i] < v[j]) {
            k = last;
            k -= 1;
            while (!(v[i] < v[k])) {
                k -= 1;
                if (k == 0) {
                    break;
                }
            }
            swap(&v[i], &v[k]);
            reverse(j, last, v);
            return true;
        }
        if (i == first) {
            reverse(first, last, v);
            return false;
        }
    }
}

pub fn rotate(first: usize, middle: usize, last: usize, v: []u8) void {
    var fir: usize, var mid: usize = .{ first, middle };
    var middle_org: usize = 0;
    if (first == middle or middle == last) {
        return;
    }
    middle_org = middle;
    while (fir != middle_org and mid != last) {
        swap(&v[fir], &v[mid]);
        fir += 1;
        mid += 1;
    }
    if (fir == middle_org) {
        rotate(fir, mid, last, v);
    } else {
        rotate(fir, middle_org, last, v);
    }
}

pub fn next_combination(first: usize, last: usize, r: usize, v: []u8) bool {
    const subset: usize = first + r;
    var src: usize = subset;
    var dst: usize = subset;

    if (first == last or first == subset or last == subset) {
        return false;
    }
    while (first != src) {
        src -= 1;
        if (v[src] < v[last - 1]) {
            while (v[src] >= v[dst]) {
                dst += 1;
            }
            swap(&v[src], &v[dst]);
            rotate(src + 1, dst + 1, last, v);
            rotate(subset, subset + (last - dst) - 1, last, v);

            return true;
        }
    }
    rotate(first, subset, last, v);
    return false;
}

pub fn gcd(a: u32, b: u32) u32 {
    var aa = a;
    var bb = b;
    var r = @mod(aa, bb);
    while (r > 0) {
        aa = bb;
        bb = r;
        r = @mod(aa, bb);
    }
    return bb;
}

test "Combination test" {
    var v = [_]u8{ 1, 2, 3, 4, 5 };
    print("v: {any} -> ", .{v});
    rotate(1, 3, 5, &v);
    print("v: {any} \n", .{v});
    var v2 = [_]u8{ 1, 2, 3, 4 };
    _ = next_combination(0, 4, 3, &v2);
    print("v2: {any}\n", .{v2});
    _ = next_combination(0, 4, 3, &v2);
    print("v2: {any}\n", .{v2});
}

//test "Permutation test" {
//    var v = [_]u8{ 1, 2, 3, 4, 5 };
//
//    print("v: {any}\n", .{v});
//    while (next_permutation(1, 5, &v)) {
//        print("v: {any}\n", .{v});
//        //;
//    }
//    return error.SkipZigTest;
//}
test "test" {
    assert(nPr(5, 3) == 60);
    assert(nCr(5, 3) == 10);
}
