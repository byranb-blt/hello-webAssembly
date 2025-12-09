@echo off
REM WebAssembly 编译脚本 (Windows)
REM 将所有的 .wat 文件编译为 .wasm 文件

echo 🔨 开始编译 WebAssembly 文件...
echo.

REM 检查 wat2wasm 是否在 PATH 中
where wat2wasm >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ❌ 错误: wat2wasm 未找到
    echo.
    echo 请确保 wabt 工具包已安装并在 PATH 中
    echo 下载地址: https://github.com/WebAssembly/wabt/releases
    exit /b 1
)

REM 编译函数
:compile_wat
if not exist "%~1" (
    echo    ⚠️  文件不存在: %~1
    goto :eof
)

echo 📝 编译: %~1 -^> %~2
wat2wasm "%~1" -o "%~2"
if %ERRORLEVEL% EQU 0 (
    echo    ✅ 成功
) else (
    echo    ❌ 失败
)
goto :eof

REM 编译各个示例
echo === 01-hello-world ===
call :compile_wat "01-hello-world\add.wat" "01-hello-world\add.wasm"

echo.
echo === 02-memory ===
call :compile_wat "02-memory\logger.wat" "02-memory\logger.wasm"

echo.
echo === 03-performance ===
call :compile_wat "03-performance\fibonacci.wat" "03-performance\fibonacci.wasm"

echo.
echo === 04-calculator ===
call :compile_wat "04-calculator\calculator.wat" "04-calculator\calculator.wasm"

echo.
echo === 05-table ===
call :compile_wat "05-table\wasm-table.wat" "05-table\wasm-table.wasm"

echo.
echo === 06-javascript-api ===
call :compile_wat "06-javascript-api\table-demo.wat" "06-javascript-api\table-demo.wasm"

echo.
echo === 09-javascript-builtins ===
call :compile_wat "09-javascript-builtins\builtins.wat" "09-javascript-builtins\builtins.wasm"

echo.
echo === 10-wasi ===
call :compile_wat "10-wasi\wasi-demo.wat" "10-wasi\wasi-demo.wasm"

echo.
echo ✅ 编译完成！
echo.
echo 现在可以启动 HTTP 服务器来运行示例：
echo   python -m http.server 8000
echo   或
echo   npx http-server

