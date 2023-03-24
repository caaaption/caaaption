open:
	open Caption.xcworkspace

clean:
	rm -rf ./.swiftpm
	rm -rf ./.build
	xcodebuild clean -alltargets

build: build-caption build-previews

PLATFORM_IOS = iOS Simulator,name=iPhone 13 Pro,OS=16.2

build-caption:
	@xcodebuild build \
		-workspace Caption.xcworkspace \
		-scheme "Caption (Staging project)" \
		-destination platform="$(PLATFORM_IOS)"
	@xcodebuild build \
		-workspace Caption.xcworkspace \
		-scheme "Caption (Production project)" \
		-destination platform="$(PLATFORM_IOS)"

build-previews:
	@xcodebuild -list -workspace ./Caption.xcworkspace
	@xcodebuild build \
		-workspace Caption.xcworkspace \
		-scheme "OnboardPreview" \
		-destination platform="$(PLATFORM_IOS)"