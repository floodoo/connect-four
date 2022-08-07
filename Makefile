run:
	flutter run

format:
	flutter format . --line-length 120 --set-exit-if-changed

format-fix:
	flutter format . --line-length 120

lint:
	flutter analyze

test:
	flutter test
.PHONY: test

packages-outdated:
	flutter pub outdated

packages-upgrade:
	flutter pub upgrade

clean:
	flutter clean
	flutter pub get
	make build-runner

build-runner:
	flutter pub run build_runner build --delete-conflicting-outputs

build-runner-watch:
	flutter pub run build_runner watch --delete-conflicting-outputs

build-ios:
	@echo "Build iOS"
	make clean
	rm -rf ios/build-output
	flutter build ipa --obfuscate --split-debug-info=./build-output/debug/ --tree-shake-icons --export-options-plist=ios/ios-export-options.plist --suppress-analytics
	cp build/ios/ipa/familydo.ipa build-output/familydo.ipa

build-android-apk:
	@echo "Build APK's"
	make clean
	flutter build apk --target-platform=android-arm,android-arm64 --obfuscate --split-debug-info=./build-output/debug/
	cp build/app/outputs/apk/release/app-release.apk build-output/
	mv build-output/app-release.apk build-output/app.apk

build-android-appbundle:
	@echo "Build Store App Bundle"
	make clean
	flutter build appbundle --obfuscate --split-debug-info=./build-output/debug/
	cp build/app/outputs/bundle/release/app-release.aab build-output/
	mv build-output/app-release.aab build-output/app.aab
