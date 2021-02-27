package main

import (
    "fmt"

    pb "test_import_path"
)

func main() {
    test := &pb.Demo{
        Field: true,
    }
    fmt.Printf("%v\n", test.GetField())
}