//! Range lets you iterate over a range of numbers. The number type, step, and
//! bounds are all configurable. Here's the logic that controls the iteration:
//!
//! 1. If `from` is less than `to`, iteration is ascending.
//! 2. If `from` is greater than `to`, iteration is descending.
//! 3. If the `to` is unspecified, iterations is ascending and unbounded.
//! 4. The step must always be a positive number and defaults to 1.
//! 5. The `to` bound is excluded.
//!
//! For integers, saturating operations (`+|`, `-|`) are used to prevent overflow.

const std = @import("std");
const testing = std.testing;
const assert = std.debug.assert;

pub fn Range(comptime T: type) type {
    const info = @typeInfo(T);
    assert(info == .Int or info == .Float);

    return struct {
        /// Start at (inclusive).
        from: T,

        /// End at (exclusive; null means unbounded).
        to: ?T = null,

        // Increment / decrement by.
        step: if (info == .Int) usize else f64 = 1,

        // Current value.
        i: ?T = null,

        const Self = @This();

        /// Returns the current iteration value or null if we reached the end.
        pub fn next(self: *Self) ?T {
            if (info == .Float) assert(self.step >= 0);

            if (self.i == null) {
                self.i = self.from;
                return self.from;
            }

            const s: T = if (info == .Int) @intCast(self.step) else @floatCast(self.step);

            if (self.to == null) {
                if (info == .Int) {
                    self.i.? +|= s;
                } else {
                    self.i.? += s;
                }

                return self.i.?;
            }

            if (self.from < self.to.?) {
                if (info == .Int) {
                    self.i.? +|= s;
                } else {
                    self.i.? += s;
                }

                return if (self.i.? < self.to.?) self.i.? else null;
            } else {
                if (info == .Int) {
                    self.i.? -|= s;
                } else {
                    self.i.? -= s;
                }

                return if (self.i.? > self.to.?) self.i.? else null;
            }
        }

        /// Set the iteration to start over at `from`.
        pub fn reset(self: *Self) void {
            self.i = null;
        }
    };
}

test "Range" {
    var r = Range(i8){ .from = 0, .to = 2 };

    try testing.expectEqual(0, r.next().?);
    try testing.expectEqual(1, r.next().?);
    try testing.expectEqual(null, r.next());

    r.reset();

    try testing.expectEqual(0, r.next().?);
    try testing.expectEqual(1, r.next().?);
    try testing.expectEqual(null, r.next());

    r = Range(i8){ .from = 0, .to = -2 };

    try testing.expectEqual(0, r.next().?);
    try testing.expectEqual(-1, r.next().?);
    try testing.expectEqual(null, r.next());

    r.reset();
    r.step = 2;

    try testing.expectEqual(0, r.next().?);
    try testing.expectEqual(null, r.next());

    r = Range(i8){ .from = 126, .to = 127, .step = 2 };

    try testing.expectEqual(126, r.next().?);
    try testing.expectEqual(null, r.next());

    r = Range(i8){ .from = -126, .to = -128, .step = 3 };

    try testing.expectEqual(-126, r.next().?);
    try testing.expectEqual(null, r.next());

    var u = Range(i8){ .from = -2, .step = 2 };

    try testing.expectEqual(-2, u.next().?);
    try testing.expectEqual(0, u.next().?);
    try testing.expectEqual(2, u.next().?);

    var f = Range(f32){ .from = -2, .step = 1.5 };

    try testing.expectEqual(-2, f.next().?);
    try testing.expectEqual(-0.5, f.next().?);
    try testing.expectEqual(1, f.next().?);
    try testing.expectEqual(2.5, f.next().?);

    f = Range(f32){ .from = 2, .to = -0.8, .step = 1.5 };

    try testing.expectEqual(2, f.next().?);
    try testing.expectEqual(0.5, f.next().?);
    try testing.expectEqual(null, f.next());
}
