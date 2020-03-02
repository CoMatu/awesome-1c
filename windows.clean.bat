@echo off
@echo.
@call flutter packages run build_runner clean
@echo.
@call flutter clean
@echo.
@timeout 60