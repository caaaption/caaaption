open:
	open caaaption.xcworkspace

clean:
	rm -rf ./.swiftpm
	rm -rf ./.build

bootstrap: secrets

build: build-caaaption

PLATFORM_IOS = iOS Simulator,name=iPhone 13 Pro,OS=16.2

build-caaaption:
	@xcodebuild build \
		-workspace caaaption.xcworkspace \
		-scheme "App (Staging project)" \
		-sdk iphonesimulator
	@xcodebuild build \
		-workspace caaaption.xcworkspace \
		-scheme "App (Production project)" \
		-sdk iphonesimulator

secrets:
	@cp Package/Sources/POAPClient/Secrets.swift.example Package/Sources/POAPClient/Secrets.swift

dgraph:
	@swift build -c release --package-path ./BuildTools/DependenciesGraph --product dgraph
	./BuildTools/DependenciesGraph/.build/release/dgraph ./Package

format:
	@swift build -c release --package-path ./BuildTools/SwiftFormatTool --product swiftformat
	./BuildTools/SwiftFormatTool/.build/release/swiftformat ./

install-template:
	@swift build -c release --package-path ./BuildTools/XCTemplateInstallerTool --product XCTemplateInstaller
	./BuildTools/XCTemplateInstallerTool/.build/release/XCTemplateInstaller --xctemplate-path XCTemplates/TCA.xctemplate

apollo-cli-install:
	@swift package --package-path ./Package --allow-writing-to-package-directory apollo-cli-install

apollo-generate:
	./Package/apollo-ios-cli generate
