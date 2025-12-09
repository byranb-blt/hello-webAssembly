# Demo 1: 大文件 Hash 性能对比

> JavaScript vs WebAssembly (Rust) - Hash 计算性能测试

## 📖 简介

本演示对比 JavaScript 和 WebAssembly (Rust) 在大文件 Hash 计算中的性能差异。

## 🎯 功能特点

- **Hash 算法**：FNV-1a（快速、简单、适合演示）
- **测试方式**：生成指定大小的随机数据，计算 Hash 值
- **性能指标**：执行时间、吞吐量（MB/s）
- **数据源**：可生成测试数据或上传文件

## 🔧 编译步骤

### 前置要求

1. **安装 Rust**：
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```

2. **安装 wasm-pack**：
   ```bash
   curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh
   ```

### 编译

```bash
cd src/11-hash
wasm-pack build --target web
```

这会生成 `pkg/` 目录，包含编译好的 WebAssembly 文件。

## 🌐 运行示例

1. 启动本地 HTTP 服务器：
   ```bash
   python3 -m http.server 8000
   ```

2. 在浏览器中打开：
   ```
   http://localhost:8000/11-hash/
   ```

3. 选择测试方式：
   - 输入数据大小（MB）并点击"开始性能测试"
   - 或选择文件进行 Hash 计算

## 📊 性能对比

### 测试结果示例

**10 MB 数据**：
- JavaScript: ~50-100 ms
- WebAssembly: ~20-40 ms
- **性能提升**: 2-3x

**100 MB 数据**：
- JavaScript: ~500-1000 ms
- WebAssembly: ~200-400 ms
- **性能提升**: 2-3x

### 性能分析

1. **WebAssembly 优势**：
   - 静态类型，编译时优化
   - 接近原生性能
   - 内存操作高效

2. **JavaScript 特点**：
   - 动态类型，运行时开销
   - JIT 编译优化有限
   - 内存管理开销

## 📁 文件说明

- `src/lib.rs` - Rust 源代码（Hash 函数实现）
- `Cargo.toml` - Rust 项目配置
- `index.html` - 演示页面
- `pkg/` - 编译输出目录（运行 wasm-pack 后生成）

## 🔍 Hash 算法说明

### FNV-1a 算法

FNV-1a (Fowler-Noll-Vo) 是一个快速、简单的哈希算法：

```rust
hash = FNV_offset_basis  // 2166136261
for each byte in data:
    hash = hash XOR byte
    hash = hash * FNV_prime  // 16777619
```

**特点**：
- 快速：单次遍历，O(n) 时间复杂度
- 简单：易于实现和理解
- 分布均匀：适合演示用途

**注意**：FNV-1a 不是加密安全的哈希算法，仅用于演示性能对比。

## 💡 使用场景

1. **文件完整性校验**：计算文件 Hash 值
2. **数据去重**：使用 Hash 值快速比较数据
3. **性能优化**：在需要大量 Hash 计算的场景中使用 WebAssembly

## 🚀 扩展建议

1. **支持更多 Hash 算法**：
   - MD5
   - SHA-256
   - CRC32

2. **流式处理**：
   - 支持大文件分块处理
   - 减少内存占用

3. **多线程处理**：
   - 使用 Web Workers
   - 并行计算多个文件

---

**创建日期**：2025年12月9日  
**示例版本**：v1.0

