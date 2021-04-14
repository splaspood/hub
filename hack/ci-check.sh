#!/usr/bin/env nix-shell
#!nix-shell -i bash ../shell.nix
# shellcheck shell=bash

set -eux

git fetch --depth=1 origin "$GITHUB_BASE_REF:$GITHUB_BASE_REF"
git fetch --depth=1 origin "$GITHUB_HEAD_REF:$GITHUB_HEAD_REF"
git diff "origin/$GITHUB_HEAD_REF..origin/$GITHUB_BASE_REF"

failed=0

if ! git ls-files '*.sh' | xargs shfmt -l -d; then
	failed=1
fi

if ! git ls-files '*.sh' | xargs shellcheck; then
	failed=1
fi

if [[ "$failed" -eq 1 ]]; then
	exit "$failed"
fi

go mod tidy
test -z "$(git status --porcelain go.mod go.sum)"

go vet ./...

go test -v ./...

go run cmd/hub/main.go build --dry-run --git-ref ""
