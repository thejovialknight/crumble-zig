const std = @import("std");
/// Zig version. When writing code that supports multiple versions of Zig, prefer
/// feature detection (i.e. with `@hasDecl` or `@hasField`) over version checks.
pub const zig_version = std.SemanticVersion.parse(zig_version_string) catch unreachable;
pub const zig_version_string = "0.12.0-dev.494+a8d2ed806";
pub const zig_backend = std.builtin.CompilerBackend.stage2_llvm;

pub const output_mode = std.builtin.OutputMode.Exe;
pub const link_mode = std.builtin.LinkMode.Dynamic;
pub const is_test = false;
pub const single_threaded = false;
pub const abi = std.Target.Abi.gnu;
pub const cpu: std.Target.Cpu = .{
    .arch = .x86_64,
    .model = &std.Target.x86.cpu.x86_64,
    .features = std.Target.x86.featureSet(&[_]std.Target.x86.Feature{
        .@"64bit",
        .adx,
        .aes,
        .avx,
        .avx2,
        .bmi,
        .bmi2,
        .clflushopt,
        .cmov,
        .cx16,
        .cx8,
        .f16c,
        .fma,
        .fsgsbase,
        .fxsr,
        .idivq_to_divl,
        .invpcid,
        .lzcnt,
        .macrofusion,
        .mmx,
        .movbe,
        .nopl,
        .pclmul,
        .popcnt,
        .prfchw,
        .rdrnd,
        .rdseed,
        .sahf,
        .sgx,
        .slow_3ops_lea,
        .slow_incdec,
        .sse,
        .sse2,
        .sse3,
        .sse4_1,
        .sse4_2,
        .ssse3,
        .vzeroupper,
        .x87,
        .xsave,
        .xsavec,
        .xsaveopt,
        .xsaves,
    }),
};
pub const os = std.Target.Os{
    .tag = .windows,
    .version_range = .{ .windows = .{
        .min = .win10_fe,
        .max = .win10_fe,
    }},
};
pub const target = std.Target{
    .cpu = cpu,
    .os = os,
    .abi = abi,
    .ofmt = object_format,
};
pub const object_format = std.Target.ObjectFormat.coff;
pub const mode = std.builtin.OptimizeMode.Debug;
pub const link_libc = true;
pub const link_libcpp = false;
pub const have_error_return_tracing = true;
pub const valgrind_support = true;
pub const sanitize_thread = false;
pub const position_independent_code = true;
pub const position_independent_executable = false;
pub const strip_debug_info = false;
pub const code_model = std.builtin.CodeModel.default;
pub const omit_frame_pointer = false;
