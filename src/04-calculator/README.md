# 完整应用示例 - 科学计算器

一个功能完整的科学计算器应用，展示 WebAssembly 在实际应用中的使用。

## 文件说明

- `calculator.wat` - WebAssembly 文本格式源代码
- `calculator.wasm` - 编译后的二进制文件（需要编译）
- `index.html` - 计算器界面

## 编译步骤

```bash
wat2wasm calculator.wat -o calculator.wasm
```

## 运行示例

1. 启动本地 HTTP 服务器
2. 在浏览器中打开 `http://localhost:8000/04-calculator/`

## 功能特性

### 基本运算
- 加法 (+)
- 减法 (-)
- 乘法 (×)
- 除法 (/)

### 科学函数
- 平方根 (√)
- 三角函数：sin, cos, tan
- 对数：ln, log10
- 绝对值 (|x|)

### 界面功能
- 数字输入
- 运算符选择
- 计算结果
- 计算历史记录

## 技术要点

1. **浮点数运算**：使用 f64 类型进行精确计算
2. **函数导出**：多个函数导出供 JavaScript 调用
3. **用户界面**：完整的 HTML/CSS/JavaScript 界面
4. **实际应用**：展示 WebAssembly 在实际项目中的应用

## 学习要点

- 如何组织多个相关函数
- 浮点数运算的精度
- 实际应用的架构设计
- JavaScript 和 WebAssembly 的交互模式

