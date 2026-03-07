#!/bin/bash
set -e

FLUTTER_HOME="/opt/flutter"

if ! command -v flutter &> /dev/null; then
  echo "Installing Flutter..."
  git clone https://github.com/flutter/flutter.git \
    --branch stable \
    --depth 1 \
    "$FLUTTER_HOME"
  export PATH="$PATH:$FLUTTER_HOME/bin"
  flutter precache --web
fi

flutter pub get
flutter build web --release
