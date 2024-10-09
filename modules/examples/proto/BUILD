load("@protobuf//bazel:cc_proto_library.bzl", "cc_proto_library")
load("@protobuf//bazel:proto_library.bzl", "proto_library")

PROTO_PATH = "/modules/examples/proto"

cc_proto_library(
    name = "geometry_cc_proto",
    visibility = ["//visibility:public"],
    deps = [":geometry"],
)

proto_library(
    name = "geometry",
    srcs = ["hephaestus/examples/types/proto/geometry.proto"],
    strip_import_prefix = PROTO_PATH,
)

cc_proto_library(
    name = "pose_cc_proto",
    visibility = ["//visibility:public"],
    deps = [":pose"],
)

proto_library(
    name = "pose",
    srcs = ["hephaestus/examples/types/proto/pose.proto"],
    strip_import_prefix = PROTO_PATH,
    deps = [":geometry"],
)

cc_proto_library(
    name = "sample_cc_proto",
    visibility = ["//visibility:public"],
    deps = [":sample"],
)

proto_library(
    name = "sample",
    srcs = ["hephaestus/examples/types/proto/sample.proto"],
    strip_import_prefix = PROTO_PATH,
)