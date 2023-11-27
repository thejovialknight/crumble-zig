const sdl = @cImport(@cInclude("SDL.h"));
const Scancode = sdl.SDL_Scancode;
const Platform = @import("platform.zig").Platform;

const NUM_BUTTONS = 3;
const MAX_BUTTON_SCANCODES = 8;

pub const Button = struct {
    scancodes: [MAX_BUTTON_SCANCODES]Scancode = undefined,
    num_scancodes: usize = 0,
    held: bool = false,
    just_pressed: bool = false,
    just_released: bool = false,
};

pub const Input = struct {
    // CONTEXT: These buttons all need to be registered in initialize_input,
    // so make sure to reflect any changes here - there.
    // Also remember to iterate NUM_BUTTONS as these are added
    left: Button = .{},
    right: Button = .{},
    jump: Button = .{},

    buttons: [NUM_BUTTONS]*Button = undefined,
};


pub fn init() Input {
    var input: Input = .{};

    // CONTEXT: These buttons all need to be defined in the Input struct,
    // so make sure to reflect any changes here - there.
    // Also remember to iterate NUM_BUTTONS as these are added
    var i: usize = 0;

    register_button_scancode(&input.left, sdl.SDL_SCANCODE_A);
    register_button_scancode(&input.left, sdl.SDL_SCANCODE_LEFT);
    register_button(&input.left, &input.buttons, &i);

    register_button_scancode(&input.right, sdl.SDL_SCANCODE_D);
    register_button_scancode(&input.right, sdl.SDL_SCANCODE_RIGHT);
    register_button(&input.right, &input.buttons, &i);

    register_button_scancode(&input.jump, sdl.SDL_SCANCODE_SPACE);
    register_button_scancode(&input.jump, sdl.SDL_SCANCODE_W);
    register_button_scancode(&input.jump, sdl.SDL_SCANCODE_UP);
    register_button(&input.jump, &input.buttons, &i);

    return input;
}

pub fn update(platform: *Platform, input: *Input) void {
    // Update buttons
    for(input.buttons) |button| {
        button.just_pressed = false;
        button.just_released = false;
    }

    for(input.buttons) |button| {
        var modified: bool = false; // to prevent false positive in keyup check
        for(0..platform.num_keydowns) |i| {
            for(button.scancodes) |scancode| {
                if(platform.keydowns[i] == scancode) {
                    if(!button.held) button.just_pressed = true;
                    button.held = true;
                    modified = true;
                }
            }
        }
        for(0..platform.num_keyups) |i| {
            for(button.scancodes) |scancode| {
                if(platform.keyups[i] == scancode) {
                    if(!modified and button.held) button.just_released = true;
                    button.held = false;
                }
            }
        }
    }
}

// Adds pointer to button list and iterates i
fn register_button(button: *Button, buttons: *[NUM_BUTTONS]*Button, registration_index: *usize) void {
    buttons[registration_index.*] = button;
    registration_index.* += 1;
}

fn register_button_scancode(button: *Button, scancode: Scancode) void {
    button.scancodes[button.num_scancodes] = scancode;
    button.num_scancodes += 1;
}
