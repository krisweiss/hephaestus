load("//bazel:hephaestus.bzl", "heph_cc_test", "heph_cc_binary", "heph_cc_library")

package(default_visibility = ["//visibility:public"])

heph_cc_library(
    name = "serdes",
    srcs = glob([
        "src/**/*.cpp",
    ]),
    hdrs = glob([
        "include/**/*.h",
    ]),
    includes = ["include"],
    visibility = ["//visibility:public"],
    deps = [
        "//modules/utils",
        "@abseil-cpp//absl/container:raw_hash_map",
        "@abseil-cpp//absl/log:log",
        "@abseil-cpp//absl/status:status",
        "@abseil-cpp//absl/status:statusor",
        "@magic_enum",
        "@protobuf",
        "@range-v3",
    ],
)

############
# Binaries #
############

heph_cc_binary(
    name = "example",
    srcs = ["examples/example.cpp"],
    deps = [
        ":serdes",
    ],
)

#########
# Tests #
#########

SERDES_TEST_DEPS = [
    ":serdes",
    "@protobuf",
    "@googletest//:gtest",
]

load("@protobuf//bazel:cc_proto_library.bzl", "cc_proto_library")
load("@protobuf//bazel:proto_library.bzl", "proto_library")

PROTO_PATH = "/modules/serdes/tests"

cc_proto_library(
    name = "test_cc_proto",
    visibility = ["//visibility:public"],
    deps = [":test"],
)

proto_library(
    name = "test",
    srcs = ["tests/test.proto"],
    strip_import_prefix = PROTO_PATH,
)

heph_cc_test(
    name = "tests",
    srcs = [
        "tests/test_proto_conversion.h",
        "tests/tests.cpp",
    ],
    deps = SERDES_TEST_DEPS + [":test_cc_proto"],
)
