const Input = @import("input.zig").Input;
const Platform = @import("platform.zig").Platform;

pub const Game = struct {
    // ---
};

pub fn init() Game {
    var game: Game = .{};
    
    // ---

    return game;
}

pub fn update(game: *Game, input: *Input, platform: *Platform) void {
    _ = game;
    _ = input;
    _ = platform;
}
