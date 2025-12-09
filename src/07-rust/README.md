# Rust 转 WebAssembly 示例

展示如何使用 Rust 编写代码并编译为 WebAssembly。

## 前置要求

1. **安装 Rust**：
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```

2. **安装 wasm-pack**：
   ```bash
   curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh
   ```

## 编译步骤

```bash
cd src/07-rust
wasm-pack build --target web
```

这会生成 `pkg/` 目录，包含编译好的 WebAssembly 文件。

## 运行示例

1. 启动本地 HTTP 服务器：
   ```bash
   python3 -m http.server 8000
   ```

2. 在浏览器中打开：
   ```
   http://localhost:8000/07-rust/
   ```

## 文件说明

- `src/lib.rs` - Rust 源代码
- `Cargo.toml` - Rust 项目配置
- `index.html` - 演示页面
- `pkg/` - 编译输出目录（运行 wasm-pack 后生成）

## Rust 特性展示

### 1. 基本函数
- 简单的加法函数
- 展示基本的函数导出

### 2. 数值计算
- 斐波那契数列（迭代版本）
- 阶乘计算
- 使用 u64 类型避免溢出

### 3. 字符串处理
- 字符串格式化
- 展示 Rust 字符串与 JavaScript 的互操作

### 4. 数组操作
- 数组求和
- 展示 Rust 切片的使用

### 5. 结构体和内存管理
- 自定义结构体
- 展示 Rust 的内存安全特性
- 自动内存管理

## 优势

1. **内存安全**：编译时保证内存安全，无需手动管理
2. **性能**：零成本抽象，接近原生性能
3. **类型安全**：强类型系统，减少运行时错误
4. **工具链**：wasm-pack 提供完整的构建工具链

## 学习资源

- [Rust 官方文档](https://www.rust-lang.org/)
- [wasm-pack 文档](https://rustwasm.github.io/wasm-pack/)
- [wasm-bindgen 文档](https://rustwasm.github.io/wasm-bindgen/)

