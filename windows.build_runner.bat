@echo off
@echo.
@echo ~~~ BUILD RUNNER
@echo.
@call flutter pub run build_runner build
@echo.
@timeout 60