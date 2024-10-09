load("//bazel:hephaestus.bzl", "heph_cc_test", "heph_cc_library")

package(default_visibility = ["//visibility:public"])

heph_cc_library(
    name = "types",
    srcs = glob([
        "src/**/*.cpp",
    ]),
    hdrs = glob([
        "include/**/*.h",
    ]),
    visibility = ["//visibility:public"],
    includes = ["include"],
    deps = [
        "//modules/random:random",
        "@fmt",
        "@magic_enum",
        "@range-v3",
    ],
)

#########
# Tests #
#########

TYPES_TEST_DEPS = [
    ":types",
    "@googletest//:gtest",
]

heph_cc_test(
    name = "bounds_tests",
    srcs = ["tests/bounds_tests.cpp"],
    deps = TYPES_TEST_DEPS,
)

heph_cc_test(
    name = "tests",
    srcs = ["tests/tests.cpp"],
    deps = TYPES_TEST_DEPS,
)

heph_cc_test(
    name = "type_formatting_tests",
    srcs = ["tests/type_formatting_tests.cpp"],
    deps = TYPES_TEST_DEPS,
)

