# Attempt to import proto file, this should succeed
import demo_pb2

# Attempt to import protobuf, this should succeed
import google.protobuf.timestamp_pb2

# Attempt to import grpc, this should succeed
import grpc

# Check the stubs are generated
import os
module_dir = os.path.dirname(demo_pb2.__file__)
assert os.path.exists(os.path.join(module_dir, 'demo_pb2.pyi'))
