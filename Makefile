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
	@cp ./Packages/ClientPackage/Sources/POAPClient/Secrets.swift.example ./Packages/ClientPackage/Sources/POAPClient/Secrets.swift
	@echo "import Foundation\n\nlet baseURL = URL(string: \"https://chaotic-quiet-meme.discover.quiknode.pro/86804d1e5443408f5fe8f2c85d421bf018dbe433\")!" > ./Packages/ClientPackage/Sources/QuickNodeClient/Secrets.swift

dgraph:
	@swift build -c release --package-path ./BuildTools/DependenciesGraph --product dgraph
	./BuildTools/DependenciesGraph/.build/release/dgraph ./Packages/caaaption

format:
	@swift build -c release --package-path ./BuildTools/SwiftFormatTool --product swiftformat
	./BuildTools/SwiftFormatTool/.build/release/swiftformat ./

install-template:
	@swift build -c release --package-path ./BuildTools/XCTemplateInstallerTool --product XCTemplateInstaller
	./BuildTools/XCTemplateInstallerTool/.build/release/XCTemplateInstaller --xctemplate-path XCTemplates/TCA.xctemplate

apollo-cli-install:
	@swift package --package-path ./Packages/caaaption --allow-writing-to-package-directory apollo-cli-install

apollo-generate:
	./Packages/caaaption/apollo-ios-cli generate --ignore-version-mismatch
