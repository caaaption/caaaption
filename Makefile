open:
	open caaaption.xcworkspace

clean:
	rm -rf **/*/.build

bootstrap: secrets

build: build-caaaption

PLATFORM_IOS = iOS Simulator,name=iPhone 14 Pro,OS=16.2

build-caaaption:
	@xcodebuild build \
		-workspace caaaption.xcworkspace \
		-scheme "App (Staging project)" \
		-sdk iphonesimulator
	@xcodebuild build \
		-workspace caaaption.xcworkspace \
		-scheme "App (Production project)" \
		-sdk iphonesimulator

test:
	@xcodebuild test \
		-workspace caaaption.xcworkspace \
		-scheme "App (Staging project)" \
		-testPlan App \
		-destination platform="$(PLATFORM_IOS)"

secrets:
	@cp ./Packages/ClientPackage/Sources/POAPClient/Secrets.swift.example ./Packages/ClientPackage/Sources/POAPClient/Secrets.swift
	@echo "import Foundation\n\nlet baseURL = URL(string: \"https://chaotic-quiet-meme.discover.quiknode.pro/86804d1e5443408f5fe8f2c85d421bf018dbe433\")!" > ./Packages/ClientPackage/Sources/QuickNodeClient/Secrets.swift

dgraph:
	@swift build -c release --package-path ./BuildTools/DependenciesGraph --product dgraph
	./BuildTools/DependenciesGraph/.build/release/dgraph --add-to-readme ./Packages/FeaturePackage
	./BuildTools/DependenciesGraph/.build/release/dgraph --add-to-readme ./Packages/WidgetPackage
	./BuildTools/DependenciesGraph/.build/release/dgraph --add-to-readme ./Packages/ClientPackage
	./BuildTools/DependenciesGraph/.build/release/dgraph --add-to-readme ./Packages/GraphQLPackage

format:
	@swift build -c release --package-path ./BuildTools/SwiftFormatTool --product swiftformat
	./BuildTools/SwiftFormatTool/.build/release/swiftformat ./

install-template:
	@swift build -c release --package-path ./BuildTools/XCTemplateInstallerTool --product XCTemplateInstaller
	./BuildTools/XCTemplateInstallerTool/.build/release/XCTemplateInstaller --xctemplate-path XCTemplates/TCA.xctemplate

apollo-cli-install:
	@swift package --package-path ./Packages/FeaturePackage --allow-writing-to-package-directory apollo-cli-install

apollo-generate:
	./Packages/FeaturePackage/apollo-ios-cli generate --ignore-version-mismatch
