const std = @import("std");
const print = std.debug.print;

pub const comments: []const u8 = "アダムズ方式で議席数を計算せよ!";

const Pop = struct {
    name: []const u8,
    population: u32,
};
const SEAT: i32 = 289;
const name = [_][]const u8{
    "北海道", "青森県",    "岩手県", "宮城県",    "秋田県", "山形県",
    "福島県", "茨城県",    "栃木県", "群馬県",    "埼玉県", "千葉県",
    "東京都", "神奈川県", "新潟県", "富山県",    "石川県", "福井県",
    "山梨県", "長野県",    "岐阜県", "静岡県",    "愛知県", "三重県",
    "滋賀県", "京都府",    "大阪府", "兵庫県",    "奈良県", "和歌山県",
    "鳥取県", "島根県",    "岡山県", "広島県",    "山口県", "徳島県",
    "香川県", "愛媛県",    "高知県", "福岡県",    "佐賀県", "長崎県",
    "熊本県", "大分県",    "宮崎県", "鹿児島県", "沖縄県",
};

const table = [_]u32{
    5381733,  1308265, 1279594, 2333899, 1023119, 1123891,
    1914039,  2916976, 1974255, 1973115, 7266534, 6222666,
    13515271, 9126214, 2304264, 1066328, 1154008, 786740,
    834930,   2098804, 2031903, 3700305, 7483128, 1815865,
    1412916,  2610353, 8839469, 5534800, 1364316, 963579,
    573441,   694352,  1921525, 2843990, 1404729, 755733,
    976263,   1385262, 728276,  5101556, 832832,  1377187,
    1786170,  1166338, 1104069, 1648177, 1433566,
};

const pop = [_]Pop{
    Pop{ .name = "AA", .population = 250 },
    Pop{ .name = "BB", .population = 200 },
    Pop{ .name = "CC", .population = 150 },
};
pub fn function() void {
    var max_tb: u32 = 0;
    const len: usize = table.len;
    var seat: [len]u32 = undefined;
    for (0..len) |i| {
        seat[i] = 0;
    }
    for (table) |no| {
        if (no > max_tb) {
            max_tb = no;
        }
    }
    var left: u32, var right: u32 = .{ 1, max_tb };
    var seat_sum: isize = 0;
    while (left < right) {
        const mid: u32 = (left + right) / 2;
        for (table, 0..) |num, i| {
            seat[i] = (num + mid - 1) / mid;
        }
        seat_sum = 0;
        for (seat) |no| {
            seat_sum += no;
        }
        if (SEAT == seat_sum) {
            print("固定数: {}\n", .{mid});
            for (seat, name) |no, na| {
                print("{s} - {}\n", .{ na, no });
            }
            break;
        } else if (SEAT > seat_sum) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
}

test "testing" {
    function();
}
