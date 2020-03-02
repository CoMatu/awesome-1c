@echo off
@echo.
@call flutter pub get
@echo.
@call flutter run -d chrome --debug --web-hostname localhost --web-port 5000
@echo.