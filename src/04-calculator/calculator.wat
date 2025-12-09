;; 完整应用示例 - 科学计算器
;; 展示实际应用场景：包含多种数学运算

(module
  ;; 导入 JavaScript Math 函数（必须在所有定义之前）
  (import "js" "Math_sin" (func $js_sin (param f64) (result f64)))
  (import "js" "Math_cos" (func $js_cos (param f64) (result f64)))
  (import "js" "Math_tan" (func $js_tan (param f64) (result f64)))
  (import "js" "Math_log" (func $js_log (param f64) (result f64)))
  (import "js" "Math_log10" (func $js_log10 (param f64) (result f64)))
  
  ;; 加法
  (func $add (param $a f64) (param $b f64) (result f64)
    (f64.add (local.get $a) (local.get $b))
  )
  (export "add" (func $add))
  
  ;; 减法
  (func $subtract (param $a f64) (param $b f64) (result f64)
    (f64.sub (local.get $a) (local.get $b))
  )
  (export "subtract" (func $subtract))
  
  ;; 乘法
  (func $multiply (param $a f64) (param $b f64) (result f64)
    (f64.mul (local.get $a) (local.get $b))
  )
  (export "multiply" (func $multiply))
  
  ;; 除法
  (func $divide (param $a f64) (param $b f64) (result f64)
    (f64.div (local.get $a) (local.get $b))
  )
  (export "divide" (func $divide))
  
  ;; 幂运算（通过循环实现，因为 WebAssembly 没有内置 pow 指令）
  ;; 注意：这是一个简化版本，只支持整数指数
  (func $power (param $base f64) (param $exponent f64) (result f64)
    (local $result f64)
    (local $exp_int i32)
    (local $i i32)
    
    ;; 将指数转换为整数（简化处理）
    (local.set $exp_int (i32.trunc_f64_s (local.get $exponent)))
    
    ;; 如果指数为0，返回1
    (if (i32.eq (local.get $exp_int) (i32.const 0))
      (then
        (f64.const 1.0)
        return
      )
    )
    
    ;; 如果指数为1，返回底数
    (if (i32.eq (local.get $exp_int) (i32.const 1))
      (then
        (local.get $base)
        return
      )
    )
    
    ;; 初始化结果
    (local.set $result (local.get $base))
    (local.set $i (i32.const 1))
    
    ;; 循环计算
    (loop $loop
      (local.set $result
        (f64.mul (local.get $result) (local.get $base))
      )
      (local.set $i
        (i32.add (local.get $i) (i32.const 1))
      )
      (br_if $loop
        (i32.lt_s (local.get $i) (local.get $exp_int))
      )
    )
    
    (local.get $result)
  )
  (export "power" (func $power))
  
  ;; 平方根
  (func $sqrt (param $x f64) (result f64)
    (f64.sqrt (local.get $x))
  )
  (export "sqrt" (func $sqrt))
  
  ;; 正弦（调用导入的 JavaScript 函数）
  (func $sin (param $x f64) (result f64)
    (call $js_sin (local.get $x))
  )
  (export "sin" (func $sin))
  
  ;; 余弦（调用导入的 JavaScript 函数）
  (func $cos (param $x f64) (result f64)
    (call $js_cos (local.get $x))
  )
  (export "cos" (func $cos))
  
  ;; 正切（调用导入的 JavaScript 函数）
  (func $tan (param $x f64) (result f64)
    (call $js_tan (local.get $x))
  )
  (export "tan" (func $tan))
  
  ;; 自然对数（调用导入的 JavaScript 函数）
  (func $ln (param $x f64) (result f64)
    (call $js_log (local.get $x))
  )
  (export "ln" (func $ln))
  
  ;; 常用对数（以10为底，调用导入的 JavaScript 函数）
  (func $log10 (param $x f64) (result f64)
    (call $js_log10 (local.get $x))
  )
  (export "log10" (func $log10))
  
  ;; 绝对值
  (func $abs (param $x f64) (result f64)
    (f64.abs (local.get $x))
  )
  (export "abs" (func $abs))
  
  ;; 向上取整
  (func $ceil (param $x f64) (result f64)
    (f64.ceil (local.get $x))
  )
  (export "ceil" (func $ceil))
  
  ;; 向下取整
  (func $floor (param $x f64) (result f64)
    (f64.floor (local.get $x))
  )
  (export "floor" (func $floor))
  
  ;; 四舍五入
  (func $round (param $x f64) (result f64)
    (f64.nearest (local.get $x))
  )
  (export "round" (func $round))
  
  ;; 计算表达式（简单的两数运算）
  ;; op: 0=+, 1=-, 2=*, 3=/
  (func $calculate (param $a f64) (param $b f64) (param $op i32) (result f64)
    (local $result f64)
    
    ;; 根据操作符选择运算
    (if (i32.eq (local.get $op) (i32.const 0))
      (then
        (local.set $result (f64.add (local.get $a) (local.get $b)))
      )
    )
    (if (i32.eq (local.get $op) (i32.const 1))
      (then
        (local.set $result (f64.sub (local.get $a) (local.get $b)))
      )
    )
    (if (i32.eq (local.get $op) (i32.const 2))
      (then
        (local.set $result (f64.mul (local.get $a) (local.get $b)))
      )
    )
    (if (i32.eq (local.get $op) (i32.const 3))
      (then
        (local.set $result (f64.div (local.get $a) (local.get $b)))
      )
    )
    
    (local.get $result)
  )
  (export "calculate" (func $calculate))
)

