# WebAssembly JavaScript Builtins 介绍

## 什么是 JavaScript Builtins？

**JavaScript Builtins** 是 WebAssembly 的一个特性，允许 Wasm 模块直接调用 JavaScript 的内置功能，而无需手动编写 JavaScript 包装代码。

## 核心概念

### 1. 导入 JavaScript 函数

WebAssembly 模块可以通过 `import` 语句导入 JavaScript 函数：

```wat
(module
  ;; 导入 JavaScript Math.sin 函数
  (import "js" "Math_sin" (func $js_sin (param f64) (result f64)))
  
  ;; 在 WebAssembly 中调用
  (func $sin (param $x f64) (result f64)
    (call $js_sin (local.get $x))
  )
  (export "sin" (func $sin))
)
```

### 2. 常见的 JavaScript Builtins

#### Math 函数
- `Math.sin`, `Math.cos`, `Math.tan` - 三角函数
- `Math.log`, `Math.log10`, `Math.exp` - 对数函数
- `Math.pow`, `Math.sqrt` - 幂运算和平方根
- `Math.abs`, `Math.floor`, `Math.ceil` - 数学工具函数

#### 字符串操作
- `String.fromCharCode` - 字符转换
- 字符串拼接、分割等操作

#### 数组操作
- `Array.prototype` 方法
- TypedArray 操作

#### 控制台输出
- `console.log`, `console.error` - 调试输出

## 使用场景

### 1. 补充 WebAssembly 缺失的功能

WebAssembly 没有内置某些高级功能（如三角函数、字符串操作），可以通过导入 JavaScript 函数来补充：

```wat
(module
  ;; WebAssembly 没有内置 pow 函数，从 JavaScript 导入
  (import "js" "Math_pow" (func $pow (param f64 f64) (result f64)))
  
  (func $power (param $base f64) (param $exp f64) (result f64)
    (call $pow (local.get $base) (local.get $exp))
  )
  (export "power" (func $power))
)
```

### 2. 与 JavaScript 生态系统集成

通过导入 JavaScript 函数，WebAssembly 可以：
- 访问 DOM API
- 调用第三方 JavaScript 库
- 使用浏览器 API

### 3. 简化开发

不需要为每个 JavaScript 功能编写包装代码，直接导入即可使用。

## 实际示例

### 示例 1: 导入 Math 函数

**WAT 代码：**
```wat
(module
  ;; 导入 JavaScript Math 函数
  (import "js" "Math_sin" (func $js_sin (param f64) (result f64)))
  (import "js" "Math_cos" (func $js_cos (param f64) (result f64)))
  (import "js" "Math_log" (func $js_log (param f64) (result f64)))
  
  ;; 导出函数
  (func $sin (param $x f64) (result f64)
    (call $js_sin (local.get $x))
  )
  (export "sin" (func $sin))
  
  (func $cos (param $x f64) (result f64)
    (call $js_cos (local.get $x))
  )
  (export "cos" (func $cos))
  
  (func $ln (param $x f64) (result f64)
    (call $js_log (local.get $x))
  )
  (export "ln" (func $ln))
)
```

**JavaScript 代码：**
```javascript
const importObject = {
  js: {
    Math_sin: (x) => Math.sin(x),
    Math_cos: (x) => Math.cos(x),
    Math_log: (x) => Math.log(x)
  }
};

const wasmModule = await WebAssembly.instantiateStreaming(
  fetch('math.wasm'),
  importObject
);

// 调用 WebAssembly 函数
const result = wasmModule.instance.exports.sin(Math.PI / 2); // 1.0
```

### 示例 2: 导入控制台函数

**WAT 代码：**
```wat
(module
  ;; 导入内存和日志函数
  (import "js" "mem" (memory 1))
  (import "console" "log" (func $log (param i32 i32)))
  
  ;; 在内存中写入字符串
  (data (i32.const 0) "Hello from WebAssembly!")
  
  ;; 导出函数
  (func (export "sayHello")
    i32.const 0   ;; 字符串偏移
    i32.const 23  ;; 字符串长度
    call $log
  )
)
```

**JavaScript 代码：**
```javascript
const memory = new WebAssembly.Memory({ initial: 1 });

const importObject = {
  js: { mem: memory },
  console: {
    log: (offset, length) => {
      const bytes = new Uint8Array(memory.buffer, offset, length);
      const string = new TextDecoder().decode(bytes);
      console.log(string);
    }
  }
};

const wasmModule = await WebAssembly.instantiateStreaming(
  fetch('logger.wasm'),
  importObject
);

wasmModule.instance.exports.sayHello(); // 输出: Hello from WebAssembly!
```

## 性能考虑

### 优点
- **简化开发**：无需编写大量包装代码
- **功能丰富**：可以利用 JavaScript 的完整功能
- **快速集成**：与现有 JavaScript 代码无缝集成

### 缺点
- **性能开销**：每次调用 JavaScript 函数都有跨边界调用的开销
- **类型转换**：需要在 JavaScript 和 WebAssembly 类型之间转换

### 最佳实践

1. **计算密集型任务**：尽量在 WebAssembly 中完成，减少 JavaScript 调用
2. **I/O 操作**：使用 JavaScript builtins 是合理的（如 DOM 操作、网络请求）
3. **数学函数**：对于简单计算，可以考虑在 WebAssembly 中实现；对于复杂函数（如三角函数），使用 JavaScript builtins 更合适

## 与不同语言的集成

### Rust (wasm-bindgen)
```rust
use wasm_bindgen::prelude::*;

#[wasm_bindgen]
extern "C" {
    #[wasm_bindgen(js_namespace = Math)]
    fn sin(x: f64) -> f64;
    
    #[wasm_bindgen(js_namespace = console)]
    fn log(s: &str);
}
```

### AssemblyScript
AssemblyScript 内置了很多 JavaScript 功能的绑定：
```typescript
import { Math } from "./bindings/dom";

export function useMath(x: f64): f64 {
  return Math.sin(x);
}
```

### C/C++ (Emscripten)
Emscripten 提供了 `emscripten.h` 头文件，可以直接调用 JavaScript：
```c
#include <emscripten.h>

EM_JS(void, console_log, (const char* str), {
  console.log(UTF8ToString(str));
});
```

## 参考资料

- [MDN WebAssembly 文档](https://developer.mozilla.org/en-US/docs/WebAssembly)
- [WebAssembly 规范](https://webassembly.github.io/spec/)
- [wasm-bindgen 文档](https://rustwasm.github.io/wasm-bindgen/)
- [AssemblyScript 文档](https://www.assemblyscript.org/)

