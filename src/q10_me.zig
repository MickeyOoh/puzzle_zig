const std = @import("std");
const print = std.debug.print;

pub const comments: []const u8 = "アダムズ方式で議席数を計算せよ!";

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    var file = try std.fs.cwd().openFile("population.txt", .{ .read = true, .write = false, .truncate = false });

    defer file.close();

    var buffer: [4096]u8 = undefined;
    var bytesRead: usize = 0;

    while (true) {
        const chunk = try file.read(buffer[0..]);
        if (chunk == 0) break;

        bytesRead += chunk;
        // Process or store the data in `buffer` here
    }

    // Optionally, you can convert the buffer to a string
    const dataAsString = std.mem.toString(buffer[0..bytesRead], allocator);

    // Now `dataAsString` contains the content of the file
    // Do further processing as needed

    // Example: Print the content
    const stdout = std.io.getStdOut().writer();
    try stdout.print("{s}", .{dataAsString});
}

test "Testing" {}
