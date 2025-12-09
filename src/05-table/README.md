# Table 使用示例

演示如何使用 Table 实现函数指针和动态函数调用。

## 文件说明

- `wasm-table.wat` - WebAssembly 文本格式源代码
- `wasm-table.wasm` - 编译后的二进制文件（需要编译）
- `index.html` - 演示页面

## 编译步骤

```bash
wat2wasm wasm-table.wat -o wasm-table.wasm
```

## 运行示例

1. 启动本地 HTTP 服务器
2. 在浏览器中打开 `http://localhost:8000/05-table/`

## 核心概念

### 为什么需要 Table？

- **函数引用不能直接存在内存中**：出于安全考虑
- **需要函数指针功能**：实现动态函数调用
- **类型安全**：Table 提供类型检查

### Table 的特点

1. **函数引用数组**：存储函数引用，而不是函数本身
2. **索引访问**：通过整数索引访问函数
3. **类型检查**：`call_indirect` 需要指定函数签名
4. **可修改**：可以在运行时修改表中的函数引用

### 使用场景

- **函数指针**：C/C++ 中的函数指针
- **虚拟函数**：面向对象编程中的虚函数表
- **插件系统**：动态加载的函数
- **回调函数**：事件处理系统

## 代码说明

### 创建 Table

```wat
(table 2 funcref)
```

### 初始化 Table

```wat
(elem (i32.const 0) $f1 $f2)
```

### 间接调用

```wat
call_indirect (type $return_i32)
```

## 学习要点

1. **Table vs Memory**：理解为什么函数引用需要 Table
2. **类型安全**：`call_indirect` 的类型检查机制
3. **动态调用**：如何实现运行时函数选择
4. **JavaScript 交互**：如何在 JavaScript 中操作 Table

