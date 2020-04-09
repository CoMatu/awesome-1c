@echo off
@echo.
@echo ~~~ DEPLOY WEB FIREBASE
@echo.
@call flutter pub get
@echo.
@call flutter pub run build_runner build
@echo.
@call flutter build web --release
@echo.
@call firebase deploy --only hosting:awesome-1c
@echo.
@timeout 5