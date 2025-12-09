// Rust 转 WebAssembly 示例
// 展示如何使用 Rust 编写并编译为 WebAssembly

use wasm_bindgen::prelude::*;

// 导出一个简单的加法函数
#[wasm_bindgen]
pub fn add(a: i32, b: i32) -> i32 {
    a + b
}

// 导出一个斐波那契函数（迭代版本）
#[wasm_bindgen]
pub fn fibonacci(n: u32) -> u64 {
    if n <= 1 {
        return n as u64;
    }
    
    let mut a: u64 = 0;
    let mut b: u64 = 1;
    
    for _ in 2..=n {
        let temp = a + b;
        a = b;
        b = temp;
    }
    
    b
}

// 导出一个阶乘函数
#[wasm_bindgen]
pub fn factorial(n: u32) -> u64 {
    let mut result: u64 = 1;
    for i in 1..=n {
        result *= i as u64;
    }
    result
}

// 导出一个字符串处理函数
#[wasm_bindgen]
pub fn greet(name: &str) -> String {
    format!("Hello, {}! Welcome to WebAssembly from Rust!", name)
}

// 导出一个数组求和函数
#[wasm_bindgen]
pub fn sum_array(arr: &[i32]) -> i32 {
    arr.iter().sum()
}

// 导出一个内存操作示例
#[wasm_bindgen]
pub struct MemoryDemo {
    data: Vec<i32>,
}

#[wasm_bindgen]
impl MemoryDemo {
    #[wasm_bindgen(constructor)]
    pub fn new() -> MemoryDemo {
        MemoryDemo {
            data: vec![1, 2, 3, 4, 5],
        }
    }
    
    #[wasm_bindgen]
    pub fn get_data(&self) -> Vec<i32> {
        self.data.clone()
    }
    
    #[wasm_bindgen]
    pub fn add_item(&mut self, item: i32) {
        self.data.push(item);
    }
    
    #[wasm_bindgen]
    pub fn sum(&self) -> i32 {
        self.data.iter().sum()
    }
}

