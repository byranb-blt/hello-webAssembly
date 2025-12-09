# 内存操作示例

演示 JavaScript 和 WebAssembly 之间的内存共享，包括字符串传递和数字存储。

## 文件说明

- `logger.wat` - WebAssembly 文本格式源代码
- `logger.wasm` - 编译后的二进制文件（需要编译）
- `index.html` - 演示页面

## 编译步骤

```bash
wat2wasm logger.wat -o logger.wasm
```

## 运行示例

1. 启动本地 HTTP 服务器
2. 在浏览器中打开 `http://localhost:8000/02-memory/`

## 核心概念

### 1. 内存导入

WebAssembly 模块可以从 JavaScript 导入内存：

```wat
(import "js" "mem" (memory 1))
```

JavaScript 端创建内存：

```javascript
const memory = new WebAssembly.Memory({ initial: 1 });
```

### 2. 字符串传递

- WebAssembly 在内存中存储字符串（使用 `data` 段）
- JavaScript 通过 `TextDecoder` 读取内存中的字节
- 需要知道字符串的偏移量和长度

### 3. 内存访问

- JavaScript 可以通过 `memory.buffer` 访问 `ArrayBuffer`
- 使用 `Uint8Array`、`DataView` 等视图操作内存
- WebAssembly 使用 `i32.load` 和 `i32.store` 指令

## 学习要点

1. **内存共享**：理解 JavaScript 和 WebAssembly 如何共享内存
2. **字符串编码**：UTF-8 编码在内存中的表示
3. **内存布局**：如何组织数据在内存中的位置
4. **数据传递**：通过内存传递复杂数据类型

