install_deps:
	go mod download

build/docker:
	CGO_ENABLED=0 go build -a -tags "osusergo netgo" --ldflags "-linkmode external -extldflags '-static'" -o build/release-notary .

# Standard go test
test:
	go test ./... -v -race

# Make sure no unnecessary dependecies are present
go-mod-tidy:
	go mod tidy -v
	git diff-index --quiet HEAD

# Run all tests & linters in CI
ci: test go-mod-tidy