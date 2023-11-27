const std = @import("std");
const Allocator = std.mem.Allocator;
const sdl = @cImport(@cInclude("SDL.h"));

const Sprite = @import("sprite.zig").Sprite;
const AudioState = @import("synth.zig").AudioState;
const Soundtrack = @import("synth.zig").Soundtrack;
const Trackhead = @import("synth.zig").Trackhead;

// Screen parameters
const LOGICAL_WIDTH = 640;
const LOGICAL_HEIGHT = 480;
const SCREEN_WIDTH = LOGICAL_WIDTH;
const SCREEN_HEIGHT = LOGICAL_HEIGHT;
// Maximum inputs
const MAX_SCANCODE_CHECK = 256;
// Maximum active output
const MAX_ONSCREEN_SPRITES = 128;
const MAX_TRACKHEADS = 16;
// Maximum assets
const MAX_TEXTURES = 2;
const MAX_SOUNDTRACKS = 32;

pub const Platform = struct {
    // SDL resources
    window: *sdl.SDL_Window = undefined,
    surface: *sdl.SDL_Surface = undefined,
    renderer: *sdl.SDL_Renderer = undefined,
    // Input state
    keydowns: [MAX_SCANCODE_CHECK]sdl.SDL_Scancode = std.mem.zeroes([256]c_uint),
    keyups: [MAX_SCANCODE_CHECK]sdl.SDL_Scancode = std.mem.zeroes([256]c_uint),
    num_keydowns: usize = 0,
    num_keyups: usize = 0,
    quit: bool = false,
    // Output state
    sprites: [MAX_ONSCREEN_SPRITES]Sprite = undefined,
    audio_state: AudioState = undefined,
    trackheads: [MAX_TRACKHEADS]Trackhead = undefined,
    // Assets
    textures: [MAX_TEXTURES]*sdl.SDL_Texture = undefined,
    soundtracks: [MAX_SOUNDTRACKS]Soundtrack = undefined,
    // DEPRECATED: Resources
    //arena_allocator: std.heap.ArenaAllocator = undefined,
    //resource_allocator: std.mem.Allocator = undefined, 
};

pub fn init() Platform {
    var platform: Platform = .{};

    _ = sdl.SDL_Init(sdl.SDL_INIT_VIDEO);
    platform.window = sdl.SDL_CreateWindow("Crumble King", sdl.SDL_WINDOWPOS_CENTERED, sdl.SDL_WINDOWPOS_CENTERED, SCREEN_WIDTH, SCREEN_HEIGHT, 0).?;
    platform.surface = sdl.SDL_GetWindowSurface(platform.window);
    platform.renderer = sdl.SDL_CreateRenderer(platform.window, 0, sdl.SDL_RENDERER_PRESENTVSYNC).?;

    return platform;

    //platform.arena_allocator = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    //platform.resource_allocator = platform.arena_allocator.allocator(); 
    //_ = sdl.SDL_SetRelativeMouseMode(sdl.SDL_TRUE);
}

pub fn update(platform: *Platform) void {
    _ = platform;
}

pub fn cleanup(platform: *Platform) void {
    sdl.SDL_DestroyWindow(platform.window);
    sdl.SDL_DestroyRenderer(platform.renderer);
    sdl.SDL_Quit();
    //platform.arena_allocator.deinit();
}

pub fn poll_events(platform: *Platform) void {
    platform.num_keydowns = 0;
    platform.num_keyups = 0;

    var event: sdl.SDL_Event = undefined;
    while(sdl.SDL_PollEvent(&event) != 0) {
        switch(event.type) {
            sdl.SDL_QUIT => platform.quit = true,
            sdl.SDL_KEYDOWN => {
                    platform.keydowns[platform.num_keydowns] = event.key.keysym.scancode;
                    platform.num_keydowns += 1;
            },
            sdl.SDL_KEYUP => {
                    platform.keyups[platform.num_keyups] = event.key.keysym.scancode;
                    platform.num_keyups += 1;
            },
            else => {},
        }
    }
}
