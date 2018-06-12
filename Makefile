VERSION_FILE="./VERSION"
VERSION=`cat $(VERSION_FILE)`

tag_release:
	git commit --allow-empty -m "[tag release]"
	git push origin $(shell git rev-parse --symbolic-full-name --abbrev-ref HEAD)

dev_setup:
	go get github.com/jessevdk/go-flags
	go get github.com/fatih/color
	go get gopkg.in/jarcoal/httpmock.v1
	go get github.com/aws/aws-sdk-go
	go get github.com/google/go-github/github
	go get golang.org/x/oauth2
	mkdir -p src/github.com/saucelabs
	rm -f src/github.com/saucelabs/sauce-runner
	ln -s $(shell pwd) src/github.com/saucelabs/sauce-runner
	pushd githooks && ./install.sh && popd

build:
	go test -v ./test
	go build -ldflags "-X main.Version=$(VERSION)" -o sauce-runner-virtual

tests:
	go test -v ./test
