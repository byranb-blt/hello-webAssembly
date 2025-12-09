# JavaScript API 示例

演示 WebAssembly JavaScript API 的各种用法和最佳实践。

## 文件说明

- `api-demo.html` - JavaScript API 演示页面
- `table-demo.wat` - Table 演示用的 WebAssembly 模块（需要编译）
- `table-demo.wasm` - 编译后的二进制文件

## 编译步骤

```bash
wat2wasm table-demo.wat -o table-demo.wasm
```

## 运行示例

1. 启动本地 HTTP 服务器
2. 在浏览器中打开 `http://localhost:8000/06-javascript-api/api-demo.html`

## API 演示内容

### 1. 流式加载 (instantiateStreaming)
- 推荐方式，性能最好
- 直接从 Response 流加载

### 2. 非流式加载 (instantiate)
- 先获取 ArrayBuffer
- 适合需要预处理的情况

### 3. 编译和实例化分离
- 先编译模块
- 可以多次实例化（模块复用）

### 4. 验证二进制代码
- 检查代码有效性
- 不执行代码，只验证格式

### 5. Memory 操作
- 创建内存
- 读写内存
- 增长内存

### 6. Table 操作
- 创建表
- 设置和获取函数（必须是 WebAssembly 函数对象）
- 增长表
- **重要**：Table 只能存储 WebAssembly 函数，不能存储普通 JavaScript 函数

### 7. Global 操作
- 创建全局变量
- 可变 vs 不可变
- 访问和修改值

### 8. 错误处理
- CompileError
- LinkError
- RuntimeError

## 最佳实践

1. **优先使用 instantiateStreaming**：性能最好
2. **模块复用**：编译一次，多次实例化
3. **错误处理**：捕获所有类型的错误
4. **内存管理**：合理设置初始和最大大小
5. **类型检查**：使用 validate 提前检查

## 学习要点

- 不同加载方式的区别和适用场景
- 如何正确使用 Memory、Table、Global
- 错误处理和调试技巧
- 性能优化建议

