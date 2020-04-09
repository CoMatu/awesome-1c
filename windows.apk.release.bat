@echo off
@echo.
@echo ~~~ RELEASE APK
@echo.
@call flutter pub get
@echo.
@call flutter pub run build_runner build
@echo.
@call flutter build appbundle --target-platform android-arm,android-arm64,android-x64 --release
@echo.
@timeout 60