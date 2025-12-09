# Hello World 示例

这是最简单的 WebAssembly 示例，展示如何定义和调用函数。

## 文件说明

- `add.wat` - WebAssembly 文本格式源代码
- `add.wasm` - 编译后的二进制文件（需要编译）
- `index.html` - 演示页面

## 编译步骤

如果只有 `.wat` 文件，需要先编译为 `.wasm`：

```bash
# 安装 wabt 工具包
# macOS: brew install wabt
# Linux: sudo apt-get install wabt
# 或从 https://github.com/WebAssembly/wabt/releases 下载

# 编译
wat2wasm add.wat -o add.wasm
```

## 运行示例

1. 启动本地 HTTP 服务器：
   ```bash
   python3 -m http.server 8000
   # 或
   npx http-server
   ```

2. 在浏览器中打开：
   ```
   http://localhost:8000/01-hello-world/
   ```

## 代码说明

### WAT 文件结构

```wat
(module
  (func $add (param $lhs i32) (param $rhs i32) (result i32)
    local.get $lhs
    local.get $rhs
    i32.add
  )
  (export "add" (func $add))
)
```

- `module` - WebAssembly 模块
- `func` - 函数定义
- `param` - 函数参数
- `result` - 返回值类型
- `local.get` - 获取局部变量/参数
- `i32.add` - 32位整数加法
- `export` - 导出函数供外部调用

## 学习要点

1. **函数定义**：如何定义带参数和返回值的函数
2. **栈操作**：理解栈机器模型（push/pop）
3. **导出**：如何将函数导出供 JavaScript 调用
4. **函数调用**：如何在 WebAssembly 内部调用其他函数

