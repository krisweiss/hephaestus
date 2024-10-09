"""
hephaestus.bzl - Bazel build rules for Hephaestus.
"""

load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library", "cc_test")

def heph_copts():
    return (
        [
            "-DEIGEN_AVOID_STL_ARRAY",
            "-Wno-sign-compare",
            "-ftemplate-depth=900",
            "-pthread",
            "-std=c++20",
            "-Iexternal/abseil-cpp~",
        ]
    )

def heph_test_linkopts():
    return (
        [
            "-lpthread",
            "-lm",
            "-lgtest_main",
            "-lstdc++",
        ]
    )

def heph_cc_test(
        copts = heph_copts(),
        extra_copts = [],
        linkopts = heph_test_linkopts(),
        extra_linkopts = [],
        **kwargs):
    cc_test(
        copts = copts + extra_copts,
        linkopts = linkopts + extra_linkopts,
        **kwargs
    )

def heph_cc_binary(
        copts = heph_copts(),
        extra_copts = [],
        linkopts = [],
        extra_linkopts = [],
        **kwargs):
    cc_binary(
        copts = copts + extra_copts,
        linkopts = linkopts + extra_linkopts,
        **kwargs
    )

def heph_cc_library(
        copts = heph_copts(),
        extra_copts = [],
        linkopts = [],
        extra_linkopts = [],
        **kwargs):
    cc_library(
        copts = copts + extra_copts,
        linkopts = linkopts + extra_linkopts,
        **kwargs
    )
