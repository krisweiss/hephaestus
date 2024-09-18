load("//bazel:hephaestus.bzl", "heph_cc_test", "heph_cc_binary", "heph_cc_library")

package(default_visibility = ["//visibility:public"])

heph_cc_library(
    name = "concurrency",
    srcs = glob([
        "src/**/*.cpp",
    ]),
    hdrs = glob([
        "include/**/*.h",
    ]),
    visibility = ["//visibility:public"],
    includes = ["include"],
    deps = [
        "//modules/containers",
        "//modules/utils",
        "@abseil-cpp//absl/log:log",
        "@magic_enum",
    ],
)

############
# Binaries #
############

heph_cc_binary(
    name = "example",
    srcs = ["examples/spinner_example.cpp"],
    deps = [
        ":concurrency",
    ],
)

#########
# Tests #
#########

CONCURRENCY_TEST_DEPS = [
    ":concurrency",
    "//modules/random",
    "@googletest//:gtest",
]

heph_cc_test(
    name = "queue_consumer_tests",
    srcs = ["tests/queue_consumer_tests.cpp"],
    deps = CONCURRENCY_TEST_DEPS,
)

heph_cc_test(
    name = "spinner_tests",
    srcs = ["tests/spinner_tests.cpp"],
    deps = CONCURRENCY_TEST_DEPS,
)
