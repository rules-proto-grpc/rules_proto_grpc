load("//go:repositories.bzl", "go_repos")

def gogo_repos(**kwargs):
    # Same as go rules as rules_go is already loading gogo protobuf
    go_repos(**kwargs)
