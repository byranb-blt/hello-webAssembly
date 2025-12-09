;; Table 演示用的简单 WebAssembly 模块
;; 提供一些函数用于 Table 演示

(module
  ;; 函数1：返回 42
  (func $func1 (result i32)
    i32.const 42
  )
  (export "func1" (func $func1))
  
  ;; 函数2：返回 13
  (func $func2 (result i32)
    i32.const 13
  )
  (export "func2" (func $func2))
  
  ;; 函数3：返回 99
  (func $func3 (result i32)
    i32.const 99
  )
  (export "func3" (func $func3))
)

