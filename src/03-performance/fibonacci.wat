;; 性能对比示例 - 斐波那契数列计算
;; 展示 WebAssembly 在计算密集型任务中的性能优势

(module
  ;; 导入内存（用于 sum_array 函数）
  (import "js" "mem" (memory 1))
  ;; 递归实现斐波那契数列（用于性能对比）
  (func $fib_recursive (param $n i32) (result i32)
    ;; 如果 n <= 1，返回 n
    (if (result i32)
      (i32.le_s (local.get $n) (i32.const 1))
      (then
        (local.get $n)
      )
      (else
        ;; fib(n-1) + fib(n-2)
        (i32.add
          (call $fib_recursive
            (i32.sub (local.get $n) (i32.const 1))
          )
          (call $fib_recursive
            (i32.sub (local.get $n) (i32.const 2))
          )
        )
      )
    )
  )
  
  ;; 迭代实现斐波那契数列（更高效）
  (func $fib_iterative (param $n i32) (result i32)
    (local $a i32)
    (local $b i32)
    (local $i i32)
    (local $temp i32)
    
    ;; 如果 n <= 1，返回 n
    (if (i32.le_s (local.get $n) (i32.const 1))
      (then
        (local.get $n)
        return
      )
    )
    
    ;; 初始化：a = 0, b = 1
    (local.set $a (i32.const 0))
    (local.set $b (i32.const 1))
    (local.set $i (i32.const 2))
    
    ;; 循环计算
    (loop $loop
      ;; temp = a + b
      (local.set $temp
        (i32.add (local.get $a) (local.get $b))
      )
      ;; a = b
      (local.set $a (local.get $b))
      ;; b = temp
      (local.set $b (local.get $temp))
      ;; i++
      (local.set $i
        (i32.add (local.get $i) (i32.const 1))
      )
      ;; 如果 i <= n，继续循环
      (br_if $loop
        (i32.le_s (local.get $i) (local.get $n))
      )
    )
    
    ;; 返回 b
    (local.get $b)
  )
  
  ;; 导出递归版本（用于性能对比）
  (export "fib_recursive" (func $fib_recursive))
  
  ;; 导出迭代版本（高效版本）
  (export "fib_iterative" (func $fib_iterative))
  
  ;; 计算阶乘（另一个计算密集型任务）
  (func $factorial (param $n i32) (result i32)
    (local $result i32)
    (local $i i32)
    
    (local.set $result (i32.const 1))
    (local.set $i (i32.const 1))
    
    (loop $loop
      ;; result *= i
      (local.set $result
        (i32.mul (local.get $result) (local.get $i))
      )
      ;; i++
      (local.set $i
        (i32.add (local.get $i) (i32.const 1))
      )
      ;; 如果 i <= n，继续循环
      (br_if $loop
        (i32.le_s (local.get $i) (local.get $n))
      )
    )
    
    (local.get $result)
  )
  
  (export "factorial" (func $factorial))
  
  ;; 计算数组求和（展示批量数据处理）
  (func $sum_array (param $ptr i32) (param $length i32) (result i32)
    (local $sum i32)
    (local $i i32)
    (local $offset i32)
    
    (local.set $sum (i32.const 0))
    (local.set $i (i32.const 0))
    
    (loop $loop
      ;; offset = ptr + i * 4 (每个i32占4字节)
      (local.set $offset
        (i32.add
          (local.get $ptr)
          (i32.mul (local.get $i) (i32.const 4))
        )
      )
      ;; sum += array[i]
      (local.set $sum
        (i32.add
          (local.get $sum)
          (i32.load (local.get $offset))
        )
      )
      ;; i++
      (local.set $i
        (i32.add (local.get $i) (i32.const 1))
      )
      ;; 如果 i < length，继续循环
      (br_if $loop
        (i32.lt_s (local.get $i) (local.get $length))
      )
    )
    
    (local.get $sum)
  )
  
  (export "sum_array" (func $sum_array))
)

