@echo off
@echo.
@call flutter channel beta
@echo.
@call flutter upgrade
@echo.
@call flutter --version
@echo.
@timeout 60