@echo off
@echo.
@echo ~~~ PUBLISH ~~~
@echo.
@call flutter pub get
@echo.
@call flutter pub run build_runner build
@echo.
@call flutter build web --release
@echo.
@timeout 60