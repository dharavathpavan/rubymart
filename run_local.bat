@echo off
cls
echo ========================================================
echo        RUBY MART - ONE CLICK LAUNCHER
echo ========================================================
echo.

:: FORCE PATH UPDATE FOR THIS SESSION
set PATH=C:\Ruby32-x64\bin;%PATH%

echo [STEP 1] Verifying Ruby...
ruby -v >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Ruby could not be started.
    echo Please ensure you ran the installer or restarted your computer.
    pause
    exit
)

echo.
echo [STEP 2] Installing Dependencies...
echo This might take a few minutes if it's the first time.
call gem install bundler:2.4.10
call bundle install

echo.
echo [STEP 3] Setting up Database...
call bundle exec rails db:create
call bundle exec rails db:migrate
call bundle exec rails db:seed

echo.
echo [STEP 4] Starting Server...
echo.
echo ========================================================
echo SERVER RUNNING AT: http://localhost:3000
echo Login: admin@rubymart.com / password
echo ========================================================
echo.
echo Press Ctrl+C to stop the server.
echo.
call bundle exec rails server
pause
