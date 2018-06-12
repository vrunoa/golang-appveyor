#!/bin/bash --noprofile
echo $(pwd)
ARTIFACT="test-build-${APPVEYOR_BUILD_NUMBER}-win32.zip"
readonly CURDIR="$(pwd)"
readonly ARTIFACTDIR="$CURDIR/build/artifacts"

# Setup
go get github.com/jessevdk/go-flags
go get github.com/fatih/color
go get gopkg.in/jarcoal/httpmock.v1
# mkdir -p src/github.com/vruno
# rm -f src/github.com/vruno/test
# ln -s . src/github.com/vruno/test

# Build
mkdir -p $ARTIFACTDIR
cp VERSION $ARTIFACTDIR
cp HELP.md $ARTIFACTDIR/README
RUNNER_VERSION=$(cat VERSION)
go build -ldflags "-X main.Version=$RUNNER_VERSION" -o $ARTIFACTDIR/test-virtual
if [ ! -f $ARTIFACTDIR/test-virtual ]; then
  echo "Failed to build"
  exit 1
fi
chmod +x $ARTIFACTDIR/test-virtual

zip -r -X $ARTIFACT $ARTIFACTDIR
if [ ! -f $TARBALL ]; then
  echo "Failed to create tarball"
  exit 1
fi

echo "Build successful"
exit 0
