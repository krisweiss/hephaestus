load("//bazel:hephaestus.bzl", "heph_cc_test", "heph_cc_library")

package(default_visibility = ["//visibility:public"])

heph_cc_library(
    name = "random",
    srcs = glob([
        "src/**/*.cpp",
    ]),
    hdrs = glob([
        "include/**/*.h",
    ]),
    visibility = ["//visibility:public"],
    includes = ["include"],
    deps = [
        "//modules/utils:utils",
        "@fmt",
        "@magic_enum",
    ],
)

#########
# Tests #
#########

RANDOM_TEST_DEPS = [
    ":random",
    "@googletest//:gtest",
]

heph_cc_test(
    name = "random_number_generator_tests",
    srcs = ["tests/random_number_generator_tests.cpp"],
    deps = RANDOM_TEST_DEPS,
)

heph_cc_test(
    name = "random_object_creator_tests",
    srcs = ["tests/random_object_creator_tests.cpp"],
    deps = RANDOM_TEST_DEPS,
)

