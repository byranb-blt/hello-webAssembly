# WASI 演示示例

> WebAssembly System Interface (WASI) - 系统接口演示

## 📖 简介

本示例演示如何使用 **WASI (WebAssembly System Interface)**，这是一个系统接口标准，允许 WebAssembly 程序与操作系统交互。

## 🎯 学习目标

- 理解 WASI 的概念和作用
- 学习如何使用 WASI 的 `fd_write` 函数
- 了解 io vector 结构的使用
- 掌握在浏览器和原生环境中运行 WASI 程序的方法

## 📁 文件说明

- `wasi-demo.wat` - WASI 演示的 WebAssembly 文本格式代码
- `wasi-demo.wasm` - 编译后的 WebAssembly 二进制文件
- `index.html` - 浏览器演示页面（使用 WASI polyfill）
- `README.md` - 本说明文档

## 🔧 编译

```bash
# 使用 wabt 工具编译
wat2wasm wasi-demo.wat -o wasi-demo.wasm
```

## 🌐 浏览器运行

1. 启动 HTTP 服务器：
```bash
# Python 3
python3 -m http.server 8000

# Node.js (需要安装 http-server)
npx http-server -p 8000

# PHP
php -S localhost:8000
```

2. 在浏览器中打开：
```
http://localhost:8000/10-wasi/
```

3. 点击按钮测试不同的功能：
   - **运行 WASI 程序** - 调用 `_start` 函数（独立程序入口点）
   - **写入自定义消息** - 调用 `writeMessage` 函数
   - **写入错误消息** - 调用 `writeError` 函数（写入到 stderr）

## 🖥️ 原生环境运行

### 使用 wasmer

```bash
# 安装 wasmer
curl https://get.wasmer.io -sSfL | sh

# 运行 WASI 程序
wasmer run wasi-demo.wasm
```

### 使用 wasmtime

```bash
# 安装 wasmtime
curl https://wasmtime.dev/install.sh -sSf | bash

# 运行 WASI 程序
wasmtime wasi-demo.wasm
```

**预期输出**：
```
Hello from WASI!
This is a WASI demo.
WebAssembly System Interface
```

## 📚 WASI 核心概念

### 1. fd_write 函数

`fd_write` 是 WASI 提供的文件写入函数，用于向文件描述符写入数据。

**函数签名**：
```wat
(func $fd_write 
  (param i32)  ; file_descriptor (1=stdout, 2=stderr)
  (param i32)  ; *iovs (io vector 数组指针)
  (param i32)  ; iovs_len (io vector 数量)
  (param i32)  ; *nwritten (写入字节数指针)
  (result i32) ; 错误码 (0=成功)
)
```

### 2. io vector 结构

io vector 是一个 8 字节的结构，用于描述要写入的数据：

```
offset 0-3: iov_base (数据指针，4字节)
offset 4-7: iov_len  (数据长度，4字节)
```

### 3. 文件描述符

- `0` - stdin（标准输入）
- `1` - stdout（标准输出）
- `2` - stderr（标准错误输出）

### 4. 入口点 _start

`_start` 是 WASI 独立程序的入口点，类似于 C 语言的 `main` 函数。当程序作为独立程序运行时，会自动调用 `_start` 函数。

## 💡 代码示例

### WAT 代码结构

```wat
(module
  ;; 导入 WASI 函数
  (import "wasi_unstable" "fd_write" 
    (func $fd_write (param i32 i32 i32 i32) (result i32)))
  
  ;; 定义内存
  (memory 1)
  (export "memory" (memory 0))
  
  ;; 在内存中写入数据
  (data (i32.const 8) "Hello from WASI!\n")
  
  ;; 主函数（入口点）
  (func $main (export "_start")
    ;; 创建 io vector
    (i32.store (i32.const 0) (i32.const 8))   ;; iov_base
    (i32.store (i32.const 4) (i32.const 18))   ;; iov_len
    
    ;; 调用 fd_write
    (call $fd_write
      (i32.const 1)   ;; stdout
      (i32.const 0)   ;; *iovs
      (i32.const 1)   ;; iovs_len
      (i32.const 100) ;; *nwritten
    )
    drop
  )
)
```

### JavaScript Polyfill

在浏览器中，需要使用 polyfill 来模拟 WASI 功能：

```javascript
const wasiPolyfill = {
  wasi_unstable: {
    fd_write: (fd, iovs, iovs_len, nwritten_ptr) => {
      // 读取 io vector
      // 读取数据
      // 输出到控制台
      // 返回成功码
      return 0;
    }
  }
};
```

## 🎓 学习要点

1. **WASI 的作用**
   - 提供统一的系统接口标准
   - 实现跨平台的可移植性
   - 在沙盒环境中安全执行

2. **io vector 的使用**
   - 理解 io vector 的结构
   - 掌握如何在内存中创建 io vector
   - 了解如何传递多个 io vector

3. **文件描述符**
   - 理解 stdout 和 stderr 的区别
   - 掌握如何选择正确的文件描述符

4. **浏览器 vs 原生环境**
   - 浏览器需要使用 polyfill
   - 原生环境可以直接运行
   - 两种环境的实现方式不同

## 🔗 相关资源

- [WASI 官网](https://wasi.dev/)
- [WASI 规范](https://github.com/WebAssembly/WASI)
- [wasmer 文档](https://docs.wasmer.io/)
- [wasmtime 文档](https://docs.wasmtime.dev/)
- [WASI polyfill](https://github.com/WebAssembly/WASI)

## 📝 注意事项

1. **浏览器限制**：浏览器环境不支持直接的系统调用，需要使用 polyfill
2. **内存对齐**：io vector 结构需要正确对齐
3. **字符串编码**：确保字符串使用 UTF-8 编码
4. **错误处理**：检查 `fd_write` 的返回值（0 表示成功）

## 🚀 扩展练习

1. **添加更多消息**：在内存中写入更多字符串并输出
2. **实现文件读取**：使用 `fd_read` 函数读取输入
3. **错误处理**：添加错误检查和错误消息输出
4. **多 io vector**：使用多个 io vector 一次性写入多段数据

---

**创建日期**：2025年12月8日  
**示例版本**：v1.0

