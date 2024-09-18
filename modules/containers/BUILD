load("//bazel:hephaestus.bzl", "heph_cc_test", "heph_cc_binary", "heph_cc_library")

package(default_visibility = ["//visibility:public"])

heph_cc_library(
    name = "containers",
    srcs = glob([
        "src/**/*.cpp",
    ]),
    hdrs = glob([
        "include/**/*.h",
    ]),
    includes = ["include"],
    visibility = ["//visibility:public"],
    deps = [
        "//modules/utils:utils",
    ],
)

############
# Binaries #
############

heph_cc_binary(
    name = "example",
    srcs = ["examples/blocking_queue_example.cpp"],
    deps = [
        ":containers",
    ],
)

#########
# Tests #
#########

CONTAINER_TEST_DEPS = [
    ":containers",
    "@googletest//:gtest",
]

heph_cc_test(
    name = "blocking_queue_tests",
    srcs = ["tests/blocking_queue_tests.cpp"],
    deps = CONTAINER_TEST_DEPS,
)
