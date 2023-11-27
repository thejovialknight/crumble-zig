const std = @import("std");

const Platform = @import("platform.zig").Platform;
const Game = @import("game.zig").Game;
const Input = @import("input.zig").Input;

const initialize_platform = @import("platform.zig").init;
const update_platform = @import("platform.zig").update;
const poll_platform_events = @import("platform.zig").poll_events;
const cleanup_platform = @import("platform.zig").cleanup;

const initialize_input = @import("input.zig").init;
const update_input = @import("input.zig").update;

const initialize_game = @import("game.zig").init;
const update_game = @import("game.zig").update;

pub fn main() void {
    var platform: Platform = initialize_platform();
    var input: Input = initialize_input();
    var game: Game = initialize_game();

    // Loop
    loop: while (true) {
        update_input(&platform, &input);
        update_game(&game, &input, &platform);
        update_platform(&platform);

        poll_platform_events(&platform);
        if(platform.quit) break :loop;
    }

    cleanup_platform(&platform);
}
