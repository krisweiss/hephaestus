//=================================================================================================
// Copyright (C) 2023-2024 HEPHAESTUS Contributors
//=================================================================================================

#include <gmock/gmock.h>
#include <gtest/gtest.h>

#include "hephaestus/serdes/protobuf/buffers.h"
#include "hephaestus/serdes/serdes.h"

// NOLINTNEXTLINE(google-build-using-namespace)
using namespace ::testing;

namespace heph::serdes::tests {

static constexpr int NUMBER = 42;

class MockProtoMessage {
public:
  // NOLINTNEXTLINE(modernize-use-trailing-return-type,bugprone-exception-escape)
  MOCK_METHOD(std::size_t, ByteSizeLong, (), (const));

  // NOLINTNEXTLINE(modernize-use-trailing-return-type,bugprone-exception-escape)
  MOCK_METHOD(bool, SerializeToArray, (void*, int), (const));

  // NOLINTNEXTLINE(modernize-use-trailing-return-type,bugprone-exception-escape)
  MOCK_METHOD(bool, ParseFromArray, (const void*, int), (const));
};

struct Data {
  int a = NUMBER;
};

}  // namespace heph::serdes::tests

namespace heph::serdes::protobuf {
template <>
struct ProtoAssociation<heph::serdes::tests::Data> {
  using Type = heph::serdes::tests::MockProtoMessage;
};
}  // namespace heph::serdes::protobuf

namespace heph::serdes::tests {

TEST(Protobuf, SerializerBuffers) {
  protobuf::SerializerBuffer buffer;
  MockProtoMessage proto;

  EXPECT_CALL(proto, ByteSizeLong).Times(1).WillOnce(Return(NUMBER));
  EXPECT_CALL(proto, SerializeToArray).Times(1);
  EXPECT_CALL(proto, ParseFromArray).Times(0);

  buffer.serialize(proto);

  auto data = std::move(buffer).exctractSerializedData();
  EXPECT_THAT(data, SizeIs(NUMBER));
}

TEST(Protobuf, DeserializerBuffers) {
  std::vector<std::byte> data{ NUMBER };
  protobuf::DeserializerBuffer buffer{ data };
  MockProtoMessage proto;

  EXPECT_CALL(proto, ByteSizeLong).Times(0);
  EXPECT_CALL(proto, SerializeToArray).Times(0);
  EXPECT_CALL(proto, ParseFromArray).Times(1).WillOnce(Return(true));

  auto res = buffer.deserialize(proto);

  EXPECT_TRUE(res);
}

void toProto(MockProtoMessage& proto, const Data& data) {
  EXPECT_CALL(proto, ByteSizeLong).Times(1).WillOnce(Return(data.a));
}

void fromProto(const MockProtoMessage& proto, Data& data) {
  (void)proto;
  data.a = NUMBER * 2;
}

TEST(Serialization, Protobuf) {
  Data data{};
  auto buffer = serialize(data);
  EXPECT_THAT(buffer, SizeIs(NUMBER));

  DefaultValue<bool>::Set(true);
  deserialize(buffer, data);
  EXPECT_EQ(data.a, NUMBER * 2);
}

}  // namespace heph::serdes::tests
