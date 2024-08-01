// This file exists only to prevent 'go mod tidy' from thinking that grpc-gateway is unused and
// removing it when renovate does a version update...
// https://github.com/golang/go/issues/25922#issuecomment-413898264

package main

import (_ "github.com/grpc-ecosystem/grpc-gateway/v2")
