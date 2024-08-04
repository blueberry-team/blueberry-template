ROOT := $(shell git rev-parse --show-toplevel)

# Detect operating system
ifeq ($(OS), Windows_NT)
    DETECTED_OS := Windows
    FLUTTER := $(shell where flutter 2>nul)
else
    DETECTED_OS := $(shell uname -s)
    ifeq ($(DETECTED_OS), Linux)
        FLUTTER := $(shell which flutter)
    else ifeq ($(DETECTED_OS), Darwin)
        FLUTTER := $(shell which flutter)
    endif
endif

# Define the default target to call all necessary targets
all: init analyze apply buildRunner

# Define the init target
init:
	@echo "Initializing Flutter project..."
ifeq ($(DETECTED_OS), Windows)
	@flutter pub get
else
	@$(FLUTTER) pub get
endif

# Define the analyze target
analyze:
	@echo "Analyzing Flutter project..."
ifeq ($(DETECTED_OS), Windows)
	-@flutter analyze
else
	-@$(FLUTTER) analyze
endif

# Define the apply target
apply:
	@echo "Applying dart fixes..."
ifeq ($(DETECTED_OS), Windows)
	@dart format .
else
	@dart format .
endif

# Define the buildRunner target
buildRunner:
	@echo "Freezed Running build runner..."
ifeq ($(DETECTED_OS), Windows)
	@flutter pub run build_runner build --delete-conflicting-outputs
else
	@$(FLUTTER) pub run build_runner build --delete-conflicting-outputs
endif

