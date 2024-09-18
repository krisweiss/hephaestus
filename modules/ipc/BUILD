load("//bazel:hephaestus.bzl", "heph_cc_test", "heph_cc_binary", "heph_cc_library")

package(default_visibility = ["//visibility:public"])

INCLUDE_PATHS = [
    "-Iexternal/_main~non_module_dependencies~zenoh-c/include/",
    "-Iexternal/_main~non_module_dependencies~zenoh-cpp/include/",
]

heph_cc_library(
    name = "ipc",
    srcs = glob([
        "src/**/*.cpp",
    ]) + [
        "@zenoh-c//:all_srcs",
        "@zenoh-cpp//:all_srcs",
    ],
    hdrs = glob([
        "include/**/*.h",
    ]),
    extra_copts = INCLUDE_PATHS,
    includes = ["include"],
    visibility = ["//visibility:public"],
    deps = [
        "//modules/ipc/proto:types_cc_proto",
        "//modules/concurrency",
        "//modules/containers",
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
    extra_copts = INCLUDE_PATHS,
    deps = [
        ":ipc",
    ],
)

heph_cc_binary(
    name = "zenoh_string_service",
    srcs = ["apps/zenoh_string_service.cpp"],
    extra_copts = INCLUDE_PATHS,
    deps = [
        ":ipc",
    ],
)

heph_cc_binary(
    name = "zenoh_topic_echo",
    srcs = ["apps/zenoh_topic_echo.cpp"],
    extra_copts = INCLUDE_PATHS,
    deps = [
        ":ipc",
    ],
)

heph_cc_binary(
    name = "zenoh_topic_list",
    srcs = ["apps/zenoh_topic_list.cpp"],
    extra_copts = INCLUDE_PATHS,
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
    extra_copts = INCLUDE_PATHS,
    deps = IPC_TEST_DEPS
)

heph_cc_test(
    name = "topic_filter_tests",
    srcs = [
        "tests/topic_filter_tests.cpp",
    ],
    extra_copts = INCLUDE_PATHS,
    deps = IPC_TEST_DEPS
)
