const std = @import("std");
const print = std.debug.print;

const Pop = struct {
    name: []const u8,
    population: u32,
};
const Choose = 10;

const pop = [_]Pop{
    Pop{ .name = "AA", .population = 250 },
    Pop{ .name = "BB", .population = 200 },
    Pop{ .name = "CC", .population = 150 },
};
pub fn chooseMember() void {
    //var total: u32 = 0;
    //var count: u32 = 0;
    //for (pop) |p| {
    //    total += p.population;
    //    count += 1;
    //    print("{} -> {}\n", .{ count, p.population });
    //}
    //const sta: usize = pop[1].population / (Choose / count);
    //const end: usize = pop[0].population / (Choose / count);
    //print("sta: {}, -> {}\n", .{ sta, end });
    //for (sta..end) |n| {
    var mem: u64 = 0;
    var DivSta: u64 = 0;
    var DivEnd: u64 = 0;
    for (1..150) |n| {
        mem = 0;
        for (pop) |p| {
            mem += (p.population + n - 1) / n;
            if (mem > Choose) {
                break;
            }
        }
        if (mem == Choose) {
            print("num: {}\n", .{n});
            DivSta = n;
            break;
        }
    }
    for (DivSta..DivSta + 20) |n| {
        mem = 0;
        for (pop) |p| {
            mem += (p.population + n - 1) / n;
        }
        if (mem < Choose) {
            print("num_last: {}\n", .{n - 1});
            DivEnd = n - 1;
            break;
        }
    }
    print("answer: {} - {} : {}\n", .{ DivSta, DivEnd, (DivSta + DivEnd) / 2 });
}

test "testing" {
    chooseMember();
}
