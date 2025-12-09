;; WebAssembly JavaScript Builtins 示例
;; 展示如何导入和使用 JavaScript 内置函数

(module
  ;; 导入 JavaScript Math 函数
  (import "js" "Math_sin" (func $js_sin (param f64) (result f64)))
  (import "js" "Math_cos" (func $js_cos (param f64) (result f64)))
  (import "js" "Math_tan" (func $js_tan (param f64) (result f64)))
  (import "js" "Math_log" (func $js_log (param f64) (result f64)))
  (import "js" "Math_log10" (func $js_log10 (param f64) (result f64)))
  (import "js" "Math_pow" (func $js_pow (param f64 f64) (result f64)))
  (import "js" "Math_abs" (func $js_abs (param f64) (result f64)))
  
  ;; 导入内存（用于字符串操作）
  (import "js" "mem" (memory 1))
  
  ;; 导入控制台日志函数
  (import "console" "log" (func $console_log (param i32 i32)))
  
  ;; 导出三角函数
  (func $sin (param $x f64) (result f64)
    (call $js_sin (local.get $x))
  )
  (export "sin" (func $sin))
  
  (func $cos (param $x f64) (result f64)
    (call $js_cos (local.get $x))
  )
  (export "cos" (func $cos))
  
  (func $tan (param $x f64) (result f64)
    (call $js_tan (local.get $x))
  )
  (export "tan" (func $tan))
  
  ;; 导出对数函数
  (func $ln (param $x f64) (result f64)
    (call $js_log (local.get $x))
  )
  (export "ln" (func $ln))
  
  (func $log10 (param $x f64) (result f64)
    (call $js_log10 (local.get $x))
  )
  (export "log10" (func $log10))
  
  ;; 导出幂运算
  (func $power (param $base f64) (param $exp f64) (result f64)
    (call $js_pow (local.get $base) (local.get $exp))
  )
  (export "power" (func $power))
  
  ;; 导出绝对值
  (func $abs (param $x f64) (result f64)
    (call $js_abs (local.get $x))
  )
  (export "abs" (func $abs))
  
  ;; 导出函数：计算 sin²(x) + cos²(x)（应该等于 1）
  (func $sinCosIdentity (param $x f64) (result f64)
    (local $sin_x f64)
    (local $cos_x f64)
    
    ;; sin(x)
    (local.set $sin_x (call $js_sin (local.get $x)))
    ;; cos(x)
    (local.set $cos_x (call $js_cos (local.get $x)))
    
    ;; sin²(x) + cos²(x)
    (f64.add
      (f64.mul (local.get $sin_x) (local.get $sin_x))
      (f64.mul (local.get $cos_x) (local.get $cos_x))
    )
  )
  (export "sinCosIdentity" (func $sinCosIdentity))
  
  ;; 导出函数：使用控制台输出
  (data (i32.const 0) "Hello from WebAssembly Builtins!")
  
  (func (export "sayHello")
    i32.const 0   ;; 字符串偏移
    i32.const 35 ;; 字符串长度
    call $console_log
  )
  
  ;; 导出函数：计算 e^x（使用 Math.pow）
  (func $exp (param $x f64) (result f64)
    ;; e ≈ 2.718281828459045
    (call $js_pow
      (f64.const 2.718281828459045)
      (local.get $x)
    )
  )
  (export "exp" (func $exp))
)

