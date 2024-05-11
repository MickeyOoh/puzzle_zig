const std = @import("std");
const print = std.debug.print;
const functb = @import("functable.zig");

pub fn main() !void {
    // Get allocator
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    // Parse args into string array (error union needs 'try')
    const args = try std.process.argsAlloc(allocator);
    //print("args type:{}\n", .{@TypeOf(args)});
    defer std.process.argsFree(allocator, args);

    // Get and print them!
    //std.debug.print("There are {d} args:\n", .{args.len});
    if (args.len < 2) {
        print("args.len: {} -> algo_exe funcname arg1 arg2...\n", .{args.len});
        print("functable list\n", .{});
        for (functb.functable) |funct| {
            print(" {s} - {s}\n", .{ funct.name, funct.comment });
        }
        print("end\n", .{});
        return;
    }
    var found: bool = false;
    for (functb.functable) |funct| {
        if (std.mem.eql(u8, funct.name, args[1])) {
            found = true;
            print("関数実行 - {s}\n", .{funct.comment});
            funct.func();
        }
    }
    if (!found) {
        print("functable list\n", .{});
        for (functb.functable) |funct| {
            print(" {s} - {s}\n", .{ funct.name, funct.comment });
        }
        print("end\n", .{});
    }
}
