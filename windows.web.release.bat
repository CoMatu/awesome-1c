@echo off
@echo.
@echo ~~~ RELEASE WEB
@echo.
@call flutter pub get
@echo.
@call flutter pub run build_runner build
@echo.
@call flutter build web --release
@echo.
@timeout 60