@echo off
@echo.
@call flutter channel dev
@echo.
@call flutter upgrade
@echo.
@call flutter --version
@echo.
@timeout 60