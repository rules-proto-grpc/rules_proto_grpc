import unittest

class TestImports(unittest.TestCase):
    def test_import_pb2(self):
        from demo import demo_pb2
        self.assertGreater(len(dir(demo_pb2)), 0)

    def test_import_pb2_grpc(self):
        from demo import demo_pb2_grpc
        self.assertGreater(len(dir(demo_pb2_grpc)), 0)

if __name__ == "__main__":
    unittest.main()
