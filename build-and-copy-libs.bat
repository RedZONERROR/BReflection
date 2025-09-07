@echo off
echo ========================================
echo Building BlackReflection Libraries
echo ========================================

REM Clean and build all modules
echo Cleaning project...
call gradlew clean
if %ERRORLEVEL% neq 0 (
    echo ERROR: Clean failed!
    pause
    exit /b 1
)

echo Building all modules...
call gradlew build
if %ERRORLEVEL% neq 0 (
    echo ERROR: Build failed!
    pause
    exit /b 1
)

echo Publishing to local Maven repository...
call gradlew publishToMavenLocal
if %ERRORLEVEL% neq 0 (
    echo ERROR: Publish failed!
    pause
    exit /b 1
)

REM Create local library folder
echo Creating local library folder...
if not exist "local-libs" mkdir "local-libs"
if not exist "local-libs\red" mkdir "local-libs\red"
if not exist "local-libs\red\blackreflection" mkdir "local-libs\red\blackreflection"

REM Copy built JAR files from build directories
echo Copying built libraries...
if exist "core\build\libs\core-1.0.0.jar" (
    copy "core\build\libs\core-1.0.0.jar" "local-libs\red\blackreflection\core-1.0.0.jar"
    echo ✓ Copied core-1.0.0.jar
) else (
    echo ✗ core-1.0.0.jar not found!
)

if exist "compiler\build\libs\compiler-1.0.0.jar" (
    copy "compiler\build\libs\compiler-1.0.0.jar" "local-libs\red\blackreflection\compiler-1.0.0.jar"
    echo ✓ Copied compiler-1.0.0.jar
) else (
    echo ✗ compiler-1.0.0.jar not found!
)

REM Copy from local Maven repository if available
echo Copying from local Maven repository...
set MAVEN_REPO=%USERPROFILE%\.m2\repository\red\blackreflection

if exist "%MAVEN_REPO%\core\1.0.0\core-1.0.0.jar" (
    copy "%MAVEN_REPO%\core\1.0.0\core-1.0.0.jar" "local-libs\red\blackreflection\core-1.0.0-maven.jar"
    echo ✓ Copied core-1.0.0-maven.jar from Maven repo
)

if exist "%MAVEN_REPO%\compiler\1.0.0\compiler-1.0.0.jar" (
    copy "%MAVEN_REPO%\compiler\1.0.0\compiler-1.0.0.jar" "local-libs\red\blackreflection\compiler-1.0.0-maven.jar"
    echo ✓ Copied compiler-1.0.0-maven.jar from Maven repo
)

REM Copy POM files if they exist
if exist "%MAVEN_REPO%\core\1.0.0\core-1.0.0.pom" (
    copy "%MAVEN_REPO%\core\1.0.0\core-1.0.0.pom" "local-libs\red\blackreflection\core-1.0.0.pom"
    echo ✓ Copied core-1.0.0.pom
)

if exist "%MAVEN_REPO%\compiler\1.0.0\compiler-1.0.0.pom" (
    copy "%MAVEN_REPO%\compiler\1.0.0\compiler-1.0.0.pom" "local-libs\red\blackreflection\compiler-1.0.0.pom"
    echo ✓ Copied compiler-1.0.0.pom
)

echo.
echo ========================================
echo Build and Copy Complete!
echo ========================================
echo.
echo Libraries copied to: %CD%\local-libs\red\blackreflection\
echo.
echo Files available:
dir "local-libs\red\blackreflection" /b
echo.
echo To use in other projects, copy the JAR files or add this folder to your project's libs directory.
echo.
pause