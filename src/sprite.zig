pub const Sprite = struct {
    texture_source: [2]@Vector(2, i32) = .{ .{ 0, 0 }, .{ 16, 16 } },
    position: @Vector(2, i32) = .{ 0, 0 },
    origin: @Vector(2, i32) = .{ 0, 0 },
    is_flipped: bool = false,
};
