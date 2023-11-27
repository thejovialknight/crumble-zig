const MAX_TRACK_STATES = 128;

pub const Oscillator = struct {
    volume: u8 = 0,
    frequency: u16 = 0,
};

pub const NoiseGenerator = struct {
    volume: u8,
};

pub const AudioState = struct {
    oscillators: [3]Oscillator = undefined,
    noise_generators: [1]NoiseGenerator = undefined,
};

pub const Soundtrack = struct {
    states: [MAX_TRACK_STATES]AudioState,
    num_states: i32 = 0,
    priority: u8 = 128,
};

pub const Trackhead = struct {
    soundtrack_index: usize = 0,
    current_state_index: usize = 0,
    time_to_next_state: f32 = 0,
};
