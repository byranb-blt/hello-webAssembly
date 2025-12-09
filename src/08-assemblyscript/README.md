# AssemblyScript 转 WebAssembly 示例

展示如何使用 AssemblyScript（TypeScript 的子集）编写代码并编译为 WebAssembly。

## 前置要求

1. **安装 Node.js**（版本 14+）

2. **安装 AssemblyScript**：
   ```bash
   npm install
   ```

## 编译步骤

```bash
cd src/08-assemblyscript
npm install
npm run build
```

这会生成 `build/release.wasm` 文件。

## 运行示例

1. 启动本地 HTTP 服务器：
   ```bash
   python3 -m http.server 8000
   ```

2. 在浏览器中打开：
   ```
   http://localhost:8000/08-assemblyscript/
   ```

## 文件说明

- `assembly/index.ts` - AssemblyScript 源代码
- `package.json` - Node.js 项目配置
- `asconfig.json` - AssemblyScript 编译配置
- `index.html` - 演示页面
- `build/` - 编译输出目录（运行 npm run build 后生成）

## AssemblyScript 特性展示

### 1. 基本函数
- 简单的加法函数
- 展示基本的函数导出

### 2. 数值计算
- 斐波那契数列（迭代版本）
- 阶乘计算
- 使用 i64 类型避免溢出

### 3. 数组操作
- 数组求和
- 展示 Int32Array 的使用

### 4. 字符串操作
- 字符串长度
- 字符串拼接
- 注意：字符串操作需要特殊的内存管理

### 5. 数学函数
- 幂运算
- 平方根
- 使用 f64 类型进行浮点运算

### 6. 类和内存管理
- 自定义类
- 展示 AssemblyScript 的面向对象特性

## AssemblyScript vs TypeScript

### 相同点
- 语法相似
- 类型系统类似
- 开发体验接近

### 不同点
- AssemblyScript 使用 WebAssembly 类型（i32, i64, f32, f64）
- 不支持所有 TypeScript 特性
- 需要显式内存管理（某些情况下）

## 优势

1. **易于学习**：对于 TypeScript/JavaScript 开发者友好
2. **类型安全**：编译时类型检查
3. **快速编译**：编译速度快
4. **性能**：编译为高效的 WebAssembly 代码

## 学习资源

- [AssemblyScript 官方文档](https://www.assemblyscript.org/)
- [AssemblyScript GitHub](https://github.com/AssemblyScript/assemblyscript)
- [AssemblyScript 示例](https://github.com/AssemblyScript/assemblyscript/tree/main/examples)

