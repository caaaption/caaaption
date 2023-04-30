open:
	open caaaption.xcworkspace

clean:
	rm -rf ./.swiftpm
	rm -rf ./.build

test: test-color-hex

build: build-caaaption

PLATFORM_IOS = iOS Simulator,name=iPhone 13 Pro,OS=16.2

test-color-hex:
	@xcodebuild test \
		-workspace caaaption.xcworkspace \
		-scheme "ColorHexTests" \
		-destination platform="$(PLATFORM_IOS)" \
		-clonedSourcePackagesDirPath SourcePackages

build-caaaption:
	@xcodebuild build \
		-workspace caaaption.xcworkspace \
		-scheme "App (Widget Staging project)" \
		-sdk iphonesimulator \
		-clonedSourcePackagesDirPath SourcePackages
	@xcodebuild build \
		-workspace caaaption.xcworkspace \
		-scheme "App (Widget Production project)" \
		-sdk iphonesimulator \
		-clonedSourcePackagesDirPath SourcePackages

format:
	@swift build -c release --package-path ./BuildTools --product swiftformat
	./BuildTools/.build/release/swiftformat ./

install-template:
	@swift build -c release --package-path ./BuildTools --product XCTemplateInstaller
	./BuildTools/.build/release/XCTemplateInstaller --xctemplate-path XCTemplates/Reducer.xctemplate
	./BuildTools/.build/release/XCTemplateInstaller --xctemplate-path XCTemplates/View.xctemplate

apollo-cli-install:
	@swift package --allow-writing-to-package-directory apollo-cli-install

apollo-generate:
	./apollo-ios-cli generate