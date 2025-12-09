// AssemblyScript 转 WebAssembly 示例
// AssemblyScript 是 TypeScript 的一个子集，可以编译为 WebAssembly

// 导出一个简单的加法函数
export function add(a: i32, b: i32): i32 {
  return a + b;
}

// 导出一个斐波那契函数（迭代版本）
export function fibonacci(n: i32): i64 {
  if (n <= 1) {
    return n;
  }
  
  let a: i64 = 0;
  let b: i64 = 1;
  
  for (let i: i32 = 2; i <= n; i++) {
    let temp: i64 = a + b;
    a = b;
    b = temp;
  }
  
  return b;
}

// 导出一个阶乘函数
export function factorial(n: i32): i64 {
  let result: i64 = 1;
  for (let i: i32 = 1; i <= n; i++) {
    result *= i;
  }
  return result;
}

// 导出一个数组求和函数
export function sumArray(arr: Int32Array): i32 {
  let sum: i32 = 0;
  for (let i: i32 = 0; i < arr.length; i++) {
    sum += arr[i];
  }
  return sum;
}

// 导出一个字符串长度函数
export function stringLength(str: string): i32 {
  return str.length;
}

// 导出一个字符串拼接函数
export function concatStrings(str1: string, str2: string): string {
  return str1 + str2;
}

// 导出一个内存操作示例（使用函数而非类）
// AssemblyScript 不支持直接导出类，所以使用函数和全局变量来模拟

// 全局数组用于演示（实际应用中应该通过参数传递）
let demoArray: Int32Array | null = null;

// 初始化演示数组
export function initDemoArray(size: i32): void {
  demoArray = new Int32Array(size);
  for (let i: i32 = 0; i < size; i++) {
    demoArray![i] = i + 1;
  }
}

// 获取数组求和
export function getDemoArraySum(): i32 {
  if (demoArray == null) {
    return 0;
  }
  let sum: i32 = 0;
  for (let i: i32 = 0; i < demoArray!.length; i++) {
    sum += demoArray![i];
  }
  return sum;
}

// 设置数组中的值
export function setDemoArrayValue(index: i32, value: i32): void {
  if (demoArray != null && index >= 0 && index < demoArray!.length) {
    demoArray![index] = value;
  }
}

// 获取数组长度
export function getDemoArrayLength(): i32 {
  return demoArray != null ? demoArray!.length : 0;
}

// 导出一个数学工具函数
export function power(base: f64, exponent: f64): f64 {
  return Math.pow(base, exponent);
}

// 导出一个平方根函数
export function sqrt(value: f64): f64 {
  return Math.sqrt(value);
}

