const std = @import("std");
const print = std.debug.print;
const power = std.math.pow;

pub const comments: []const u8 = "ナルシシストな8進数";
const N = 8; // 8 進数
// 10進数の場合
// n桁の自然数は最小で10の(n-1)乗。
// n桁の各数字をn乗した値の和の最大は「9がn個並んだ時」なので
// 最大でn x 9のn乗となる。n x pow(9, n) < pow(10, n - 1)
// N進数の場合 n x pow(N - 1, n) < pow(N, n - 1)の条件になる
// 桁数n(keta)を求める
pub fn narcissistic_number() void {
    // ketaが44になるので、128でもオーバーフローで計算できない
    //var keta: u128 = 1;
    //while (true) : (keta += 1) {
    //    var number: u128 = keta * power(u128, N - 1, keta);
    //    var adds: u128 = power(u128, N, keta - 1);
    //    if (number < adds) {
    //        break;
    //    }
    //    if (keta > 20) {
    //        print("number:{} - {} adds\n", .{ number, adds });
    //        break;
    //    } else {
    //        print("{} n:{}-{}:as\n", .{ (number - adds), number, adds });
    //    }
    //}
    //print("keta:{}\n", .{keta});
    // このオーバーフローのため、固定で10桁までのデータを処理する事にする
    var cnt: u8 = 0;
    for (N..MAX_NUM) |n_10| {
        var total: u64 = 0;
        const N_8 = conv_number(n_10, N);
        var n_8 = N_8;
        var nth: u64 = 0;
        while (n_8 > 0) : (n_8 /= 10) {
            nth += 1;
        }
        n_8 = N_8;
        while (n_8 > 0) : (n_8 /= 10) {
            total += power(u64, @mod(n_8, 10), nth);
        }
        if (n_10 == total) {
            cnt += 1;
            print("{}: {}\n", .{ cnt, N_8 });
        }
        if (cnt >= 8) {
            break;
        }
    }
}
const MAX_NUM = power(u64, N, 7); // 最大の桁数

fn conv_number(num: u64, base: u64) u64 {
    var keta: usize = 0;
    var n: u64 = num;
    var num8_10: u64 = 0;
    while (n > 0) : (n /= base) {
        num8_10 += @mod(n, base) * power(u64, 10, keta);
        keta += 1;
    }
    return num8_10;
}

test "narcissistic number" {
    narcissistic_number();
}
