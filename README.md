# WebAssembly 技术分享演示代码

本目录包含技术分享中使用的所有示例代码。

## 📁 目录结构

```
src/
├── 01-hello-world/          # Hello World 示例
│   ├── add.wat              # WebAssembly 文本格式
│   ├── add.wasm             # 编译后的二进制（需编译）
│   ├── index.html           # 演示页面
│   └── README.md            # 说明文档
├── 02-memory/               # 内存操作示例
│   ├── logger.wat
│   ├── logger.wasm
│   ├── index.html
│   └── README.md
├── 03-performance/          # 性能对比示例（基础）
│   ├── fibonacci.wat
│   ├── fibonacci.wasm
│   ├── index.html
│   └── README.md
├── 04-calculator/           # 完整应用示例（计算器）
│   ├── calculator.wat
│   ├── calculator.wasm
│   ├── index.html
│   └── README.md
├── 05-table/                # Table 使用示例
│   ├── wasm-table.wat
│   ├── wasm-table.wasm
│   ├── index.html
│   └── README.md
├── 06-javascript-api/       # JavaScript API 示例
│   ├── table-demo.wat
│   ├── table-demo.wasm
│   ├── api-demo.html
│   └── README.md
├── 07-rust/                 # Rust 转 WebAssembly 示例
│   ├── src/lib.rs
│   ├── Cargo.toml
│   ├── index.html
│   └── README.md
├── 08-assemblyscript/       # AssemblyScript 转 WebAssembly 示例
│   ├── assembly/index.ts
│   ├── package.json
│   ├── asconfig.json
│   ├── index.html
│   └── README.md
├── 09-javascript-builtins/  # JavaScript Builtins 示例
│   ├── builtins.wat
│   ├── builtins.wasm
│   ├── index.html
│   └── README.md
├── 10-wasi/                 # WASI 系统接口示例
│   ├── wasi-demo.wat
│   ├── wasi-demo.wasm
│   ├── index.html
│   └── README.md
├── 11-hash/                 # 大文件 Hash 性能对比（Rust）
│   ├── src/lib.rs
│   ├── Cargo.toml
│   ├── index.html
│   └── README.md
├── 12-image-processing/    # 图片灰度处理性能对比
│   ├── grayscale.wat
│   ├── grayscale.wasm
│   ├── index.html
│   └── README.md
├── 13-sorting/              # 复杂排序性能对比
│   ├── sort.wat
│   ├── sort.wasm
│   ├── index.html
│   └── README.md
├── compile.sh               # 编译脚本 (macOS/Linux)
├── compile.bat              # 编译脚本 (Windows)
└── README.md                # 本文件
```

## 🚀 快速开始

### 步骤 1: 编译 WebAssembly 文件

**macOS/Linux:**
```bash
cd src
./compile.sh
```

**Windows:**
```cmd
cd src
compile.bat
```

**手动编译（如果脚本不可用）:**
```bash
# 需要先安装 wabt
# macOS: brew install wabt
# Linux: sudo apt-get install wabt

# WAT 文件编译
wat2wasm 01-hello-world/add.wat -o 01-hello-world/add.wasm
wat2wasm 02-memory/logger.wat -o 02-memory/logger.wasm
wat2wasm 03-performance/fibonacci.wat -o 03-performance/fibonacci.wasm
wat2wasm 04-calculator/calculator.wat -o 04-calculator/calculator.wasm
wat2wasm 05-table/wasm-table.wat -o 05-table/wasm-table.wasm
wat2wasm 06-javascript-api/table-demo.wat -o 06-javascript-api/table-demo.wasm
wat2wasm 09-javascript-builtins/builtins.wat -o 09-javascript-builtins/builtins.wasm
wat2wasm 10-wasi/wasi-demo.wat -o 10-wasi/wasi-demo.wasm
wat2wasm 12-image-processing/grayscale.wat -o 12-image-processing/grayscale.wasm
wat2wasm 13-sorting/sort.wat -o 13-sorting/sort.wasm

# Rust 示例（需要先安装 Rust 和 wasm-pack）
cd 07-rust
wasm-pack build --target web
cd ..

cd 11-hash
wasm-pack build --target web
cd ..

# AssemblyScript 示例（需要先安装 Node.js）
cd 08-assemblyscript
npm install
npm run build
cd ..
```

### 步骤 2: 启动 HTTP 服务器

由于浏览器安全限制，必须通过 HTTP 服务器访问：

```bash
# 使用 Python 3
python3 -m http.server 8000

# 或使用 Node.js
npx http-server
```

### 步骤 3: 访问示例

在浏览器中打开：

**基础示例**：
- Hello World: `http://localhost:8000/01-hello-world/`
- 内存操作: `http://localhost:8000/02-memory/`
- 性能对比: `http://localhost:8000/03-performance/`
- 计算器: `http://localhost:8000/04-calculator/`
- Table示例: `http://localhost:8000/05-table/`
- JavaScript API: `http://localhost:8000/06-javascript-api/api-demo.html`

**多语言编译示例**：
- Rust示例: `http://localhost:8000/07-rust/`
- AssemblyScript示例: `http://localhost:8000/08-assemblyscript/`

**高级特性示例**：
- JavaScript Builtins: `http://localhost:8000/09-javascript-builtins/`
- WASI系统接口: `http://localhost:8000/10-wasi/`

**性能对比示例**：
- 大文件Hash: `http://localhost:8000/11-hash/`
- 图片灰度处理: `http://localhost:8000/12-image-processing/`
- 复杂排序: `http://localhost:8000/13-sorting/`

### 前置要求

1. **wabt 工具包**：用于编译 WAT 到 WASM
   - [下载地址](https://github.com/WebAssembly/wabt/releases)
   - macOS: `brew install wabt`
   - Linux: `sudo apt-get install wabt`
   - Windows: 从 [GitHub Releases](https://github.com/WebAssembly/wabt/releases) 下载

2. **Rust 工具链**（用于 Rust 示例）：
   - 安装 Rust: `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`
   - 安装 wasm-pack: `curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh`

3. **Node.js**（用于 AssemblyScript 示例）：
   - 安装 Node.js: [nodejs.org](https://nodejs.org/)
   - 版本要求: Node.js 14+

4. **现代浏览器**：
   - Chrome 57+, Firefox 52+, Safari 11+, Edge 16+

5. **HTTP 服务器**：Python、Node.js 或任何静态文件服务器

## 📝 示例说明

### 基础示例

#### 01-hello-world
最简单的WebAssembly示例，展示如何定义和调用函数。适合初学者入门。

#### 02-memory
演示JavaScript和WebAssembly之间的内存共享，包括字符串传递和内存操作。

#### 03-performance
基础性能对比示例，展示JavaScript和WebAssembly在计算密集型任务（斐波那契、阶乘、数组求和）中的性能差异。

#### 04-calculator
完整的计算器应用，展示实际应用场景，包含完整的用户界面和逻辑处理。

#### 05-table
演示Table的使用，实现函数指针功能，展示如何通过索引调用函数。

#### 06-javascript-api
展示WebAssembly JavaScript API的各种用法，包括Module、Instance、Memory、Table等核心API。

### 多语言编译示例

#### 07-rust
使用 Rust 编写代码并编译为 WebAssembly 的示例。展示 Rust 的内存安全和性能优势。

#### 08-assemblyscript
使用 AssemblyScript（TypeScript 子集）编写代码并编译为 WebAssembly 的示例。适合前端开发者快速上手。

### 高级特性示例

#### 09-javascript-builtins
展示如何在 WebAssembly 中使用 JavaScript 内置函数（Math、console 等）的示例。演示导入机制的使用。

#### 10-wasi
WASI (WebAssembly System Interface) 演示示例，展示如何在 WebAssembly 中使用系统接口（如文件I/O）。可以在浏览器和原生环境中运行。

### 性能对比示例

#### 11-hash
大文件 Hash 性能对比（Rust实现）。对比 JavaScript 和 WebAssembly 在 FNV-1a 哈希算法计算中的性能差异，支持大文件上传和性能测试。

#### 12-image-processing
图片灰度处理性能对比。对比 JavaScript Canvas API 和 WebAssembly 在图像处理中的性能差异，支持图片上传和实时预览。

#### 13-sorting
复杂排序性能对比。对比 JavaScript 和 WebAssembly 在大规模数据排序（快速排序、冒泡排序）中的性能差异，支持100万数据测试。

## 🔧 编译说明

### WAT 到 WASM

如果只有`.wat`文件，需要编译为`.wasm`：

```bash
# 安装wabt后
wat2wasm example.wat -o example.wasm
```

### Rust 项目编译

```bash
cd 07-rust  # 或 11-hash
wasm-pack build --target web
```

编译完成后，会在 `pkg/` 目录下生成 `.wasm` 文件和 JavaScript 绑定文件。

### AssemblyScript 项目编译

```bash
cd 08-assemblyscript
npm install
npm run build
```

编译完成后，会在 `build/` 目录下生成 `.wasm` 文件。

## ⚠️ 注意事项

1. **浏览器安全限制**：必须通过 HTTP 服务器访问，不能直接打开 HTML 文件（file:// 协议）

2. **编译顺序**：
   - WAT 文件可以直接使用编译脚本批量编译
   - Rust 项目需要单独编译，编译时间较长
   - AssemblyScript 项目需要先安装依赖

3. **性能测试**：
   - 性能对比结果会因浏览器、硬件环境而异
   - 建议在相同环境下多次测试取平均值

4. **文件大小**：
   - Rust 编译的 `.wasm` 文件可能较大，这是正常的
   - 生产环境可以使用 `wasm-opt` 优化文件大小

## 📚 参考资源

### 官方文档
- [MDN WebAssembly文档](https://developer.mozilla.org/en-US/docs/WebAssembly)
- [WebAssembly规范](https://webassembly.github.io/spec/)
- [WebAssembly官网](https://webassembly.org/)

### 教程资源
- [WASM汇编入门教程](https://evian-zhang.github.io/wasm-tutorial/)
- [Rust WebAssembly Book](https://rustwasm.github.io/docs/book/)
- [AssemblyScript文档](https://www.assemblyscript.org/)

### 工具资源
- [wabt - WebAssembly Binary Toolkit](https://github.com/WebAssembly/wabt)
- [wasm-pack - Rust到WebAssembly工具](https://rustwasm.github.io/wasm-pack/)
- [wasm-opt - WebAssembly优化工具](https://github.com/WebAssembly/binaryen)

---

**最后更新**：2025年12月9日

