load("@rules_foreign_cc//foreign_cc:defs.bzl", "cmake")
load("//bazel:hephaestus.bzl", "heph_cc_binary", "heph_cc_library", "heph_cc_test")

package(default_visibility = ["//visibility:public"])

cmake(
    name = "zenoh-c",
    cache_entries = {
        "ZENOHC_CARGO_CHANNEL": "+stable",
        "ZENOHC_BUILD_WITH_SHARED_MEMORY": "TRUE",
        "ZENOHC_BUILD_WITH_UNSTABLE_API": "TRUE",
        "ZENOHC_LIB_STATIC": "TRUE",
        "ZENOHC_INSTALL_STATIC_LIBRARY": "TRUE",
    },
    lib_source = "@zenoh-c//:all_srcs",
    out_include_dir = "include",
    out_shared_libs = ["libzenohc.so"],
    tags = ["local"],  # have to break the sandbox to build ring@0.17.8
    visibility = ["//visibility:public"],
)

cmake(
    name = "zenoh-cpp",
    cache_entries = {
        "Z_FEATURE_UNSTABLE_API": "1",
        "ZENOHCXX_EXAMPLES_PROTOBUF": "OFF",
        "zenohc_DIR": "$EXT_BUILD_DEPS/zenoh-c/lib/cmake/zenohc/",
    },
    copts = [
        "-Iexternal/abseil-cpp~",
    ],
    lib_source = "@zenoh-cpp//:all_srcs",
    out_headers_only = True,
    out_include_dir = "include",
    visibility = ["//visibility:public"],
    deps = [
        ":zenoh-c",
        "@protobuf",
    ],
)

heph_cc_library(
    name = "ipc",
    srcs = glob([
        "src/**/*.cpp",
    ]),
    hdrs = glob([
        "include/**/*.h",
    ]),
    defines = [
        "ZENOH_WITH_UNSTABLE_API",
        "ZENOHCXX_ZENOHC",
    ],
    includes = ["include"],
    visibility = ["//visibility:public"],
    deps = [
        ":zenoh-c",
        ":zenoh-cpp",
        "//modules/cli",
        "//modules/concurrency",
        "//modules/containers",
        "//modules/ipc/proto:types_cc_proto",
        "//modules/serdes",
        "//modules/utils",
        "@abseil-cpp//absl/container:raw_hash_map",
        "@abseil-cpp//absl/log:log",
        "@abseil-cpp//absl/status:status",
        "@abseil-cpp//absl/status:statusor",
        "@fmt",
        "@nlohmann_json//:json",
        "@range-v3",
    ],
)

############
# Binaries #
############

heph_cc_binary(
    name = "zenoh_node_list",
    srcs = ["apps/zenoh_node_list.cpp"],
    deps = [
        ":ipc",
    ],
)

heph_cc_binary(
    name = "zenoh_string_service",
    srcs = ["apps/zenoh_string_service.cpp"],
    deps = [
        ":ipc",
    ],
)

heph_cc_binary(
    name = "zenoh_topic_echo",
    srcs = ["apps/zenoh_topic_echo.cpp"],
    deps = [
        ":ipc",
    ],
)

heph_cc_binary(
    name = "zenoh_topic_list",
    srcs = ["apps/zenoh_topic_list.cpp"],
    deps = [
        ":ipc",
    ],
)

#########
# Tests #
#########

IPC_TEST_DEPS = [
    ":ipc",
    "@googletest//:gtest",
]

heph_cc_test(
    name = "dynamic_subscriber_tests",
    srcs = [
        "tests/dynamic_subscriber_tests.cpp",
    ],
    deps = IPC_TEST_DEPS,
)

heph_cc_test(
    name = "topic_filter_tests",
    srcs = [
        "tests/topic_filter_tests.cpp",
    ],
    deps = IPC_TEST_DEPS,
)
