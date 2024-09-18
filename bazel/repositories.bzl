"""
repositories.bzl - Bazel repository definitions for Hephaestus
"""

load(
    "@bazel_tools//tools/build_defs/repo:git.bzl",
    "new_git_repository",
)
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def init_repositories():
    """
    Initialize the repositories.
    """
    RANGES_COMMIT = "a81477931a8aa2ad025c6bda0609f38e09e4d7ec"

    http_archive(
        name = "range-v3",
        urls = ["https://github.com/ericniebler/range-v3/archive/{commit}.tar.gz".format(commit = RANGES_COMMIT)],
        strip_prefix = "range-v3-" + RANGES_COMMIT,
        sha256 = "612b5d89f58a578240b28a1304ffb0d085686ebe0137adf175ed0e3382b7ed58",
    )

    ZENOH_VERSION = "0.11.0.3"

    _ALL_CONTENT = """
filegroup(
    name = "all_srcs",
    srcs = glob(["**"]),
    visibility = ["//visibility:public"],
)
"""

    http_archive(
        name = "zenoh-c",
        build_file_content = _ALL_CONTENT,
        urls = ["https://github.com/eclipse-zenoh/zenoh-c/releases/download/{version}/zenoh-c-{version}-x86_64-unknown-linux-gnu-standalone.zip".format(version = ZENOH_VERSION)],
        sha256 = "e1808fcd6ff155a9bcd6d819de2233305fd3c1b0e07bb9af0b81aa56b3c8c1f3",
    )

    http_archive(
        name = "zenoh-cpp",
        build_file_content = _ALL_CONTENT,
        urls = ["https://github.com/eclipse-zenoh/zenoh-cpp/releases/download/{version}/zenoh-cpp-{version}.zip".format(version = ZENOH_VERSION)],
        strip_prefix = "zenoh-cpp-" + ZENOH_VERSION,
        sha256 = "3540b8b05688d3a460312bdecb7dcbf85b8d1348ba07374dd0faec90c5a8184c",
    )
