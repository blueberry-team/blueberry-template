ROOT := $(shell git rev-parse --show-toplevel)

# Use 'where' instead of 'which' for Windows compatibility
FLUTTER := $(shell where flutter 2>nul)

# Define the init target
init:
	@echo "Initializing Flutter project..."
	@flutter pub get

# Define the fluttergen target
fluttergen:
	@echo "🔧 Running fluttergen..."
	@fluttergen

# Define the buildRunner target
buildRunner:
	@echo "❄️ Running build runner..."
	@flutter pub run build_runner build --delete-conflicting-outputs
