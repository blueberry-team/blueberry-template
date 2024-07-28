ROOT := $(shell git rev-parse --show-toplevel)

FLUTTER := $(shell which flutter)


buildRunner:
	@echo "❄️freezed build runner start"
	@${FLUTTER} pub run build_runner build --delete-conflicting-outputs
