#!/bin/bash

# WebAssembly 编译脚本
# 将所有的 .wat 文件编译为 .wasm 文件

echo "🔨 开始编译 WebAssembly 文件..."
echo ""

# 检查 wat2wasm 是否安装
if ! command -v wat2wasm &> /dev/null; then
    echo "❌ 错误: wat2wasm 未安装"
    echo ""
    echo "请先安装 wabt 工具包:"
    echo "  macOS:   brew install wabt"
    echo "  Linux:   sudo apt-get install wabt"
    echo "  Windows: 从 https://github.com/WebAssembly/wabt/releases 下载"
    exit 1
fi

# 编译函数
compile_wat() {
    local wat_file=$1
    local wasm_file=$2
    
    if [ -f "$wat_file" ]; then
        echo "📝 编译: $wat_file -> $wasm_file"
        wat2wasm "$wat_file" -o "$wasm_file"
        if [ $? -eq 0 ]; then
            echo "   ✅ 成功"
        else
            echo "   ❌ 失败"
            return 1
        fi
    else
        echo "   ⚠️  文件不存在: $wat_file"
    fi
}

# 编译各个示例
echo "=== 01-hello-world ==="
compile_wat "01-hello-world/add.wat" "01-hello-world/add.wasm"

echo ""
echo "=== 02-memory ==="
compile_wat "02-memory/logger.wat" "02-memory/logger.wasm"

echo ""
echo "=== 03-performance ==="
compile_wat "03-performance/fibonacci.wat" "03-performance/fibonacci.wasm"

echo ""
echo "=== 04-calculator ==="
compile_wat "04-calculator/calculator.wat" "04-calculator/calculator.wasm"

echo ""
echo "=== 05-table ==="
compile_wat "05-table/wasm-table.wat" "05-table/wasm-table.wasm"

echo ""
echo "=== 06-javascript-api ==="
compile_wat "06-javascript-api/table-demo.wat" "06-javascript-api/table-demo.wasm"

echo ""
echo "=== 09-javascript-builtins ==="
compile_wat "09-javascript-builtins/builtins.wat" "09-javascript-builtins/builtins.wasm"

echo ""
echo "=== 10-wasi ==="
compile_wat "10-wasi/wasi-demo.wat" "10-wasi/wasi-demo.wasm"

echo ""
echo "✅ 编译完成！"
echo ""
echo "现在可以启动 HTTP 服务器来运行示例："
echo "  python3 -m http.server 8000"
echo "  或"
echo "  npx http-server"

