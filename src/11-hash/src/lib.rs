// Hash 计算演示 - Rust 转 WebAssembly
// 对比 JavaScript 和 WebAssembly 在大文件 Hash 计算中的性能

use wasm_bindgen::prelude::*;

// 简单的哈希函数实现（FNV-1a 算法）
#[wasm_bindgen]
pub fn hash_data(data: &[u8]) -> u32 {
    let mut hash: u32 = 2166136261; // FNV offset basis
    
    for &byte in data {
        hash ^= byte as u32;
        hash = hash.wrapping_mul(16777619); // FNV prime
    }
    
    hash
}

// 计算大块数据的哈希（分块处理）
#[wasm_bindgen]
pub fn hash_large_data(data: &[u8], chunk_size: usize) -> u32 {
    let mut hash: u32 = 2166136261;
    
    for chunk in data.chunks(chunk_size) {
        for &byte in chunk {
            hash ^= byte as u32;
            hash = hash.wrapping_mul(16777619);
        }
    }
    
    hash
}

