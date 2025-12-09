;; 复杂排序性能对比 - WebAssembly 实现
;; 对比 JavaScript 和 WebAssembly 对 100 万数据的排序性能

(module
  ;; 导入内存
  (import "js" "mem" (memory 1))
  
  ;; 快速排序函数（递归实现）
  ;; 参数：
  ;;   - offset: 数组在内存中的起始偏移量
  ;;   - left: 左边界索引
  ;;   - right: 右边界索引
  (func $quicksort (param $offset i32) (param $left i32) (param $right i32)
    (local $pivot i32)
    (local $i i32)
    (local $j i32)
    (local $temp i32)
    (local $pivot_value i32)
    
    ;; 如果 left >= right，返回
    (if (i32.ge_s (local.get $left) (local.get $right))
      (then return)
    )
    
    ;; 选择中间元素作为 pivot
    (local.set $pivot
      (i32.div_s
        (i32.add (local.get $left) (local.get $right))
        (i32.const 2)
      )
    )
    
    ;; 读取 pivot 值
    (local.set $pivot_value
      (i32.load
        (i32.add
          (local.get $offset)
          (i32.mul (local.get $pivot) (i32.const 4))
        )
      )
    )
    
    ;; 交换 pivot 和 right
    (local.set $temp
      (i32.load
        (i32.add
          (local.get $offset)
          (i32.mul (local.get $right) (i32.const 4))
        )
      )
    )
    (i32.store
      (i32.add
        (local.get $offset)
        (i32.mul (local.get $pivot) (i32.const 4))
      )
      (local.get $temp)
    )
    (i32.store
      (i32.add
        (local.get $offset)
        (i32.mul (local.get $right) (i32.const 4))
      )
      (local.get $pivot_value)
    )
    
    ;; 分区操作
    (local.set $i (local.get $left))
    (local.set $j (local.get $left))
    
    (loop $partition_loop
      (if (i32.lt_s (local.get $j) (local.get $right))
        (then
          ;; 如果 arr[j] < pivot_value，交换 arr[i] 和 arr[j]
          (if (i32.lt_s
                (i32.load
                  (i32.add
                    (local.get $offset)
                    (i32.mul (local.get $j) (i32.const 4))
                  )
                )
                (local.get $pivot_value)
              )
            (then
              ;; 交换 arr[i] 和 arr[j]
              (local.set $temp
                (i32.load
                  (i32.add
                    (local.get $offset)
                    (i32.mul (local.get $i) (i32.const 4))
                  )
                )
              )
              (i32.store
                (i32.add
                  (local.get $offset)
                  (i32.mul (local.get $i) (i32.const 4))
                )
                (i32.load
                  (i32.add
                    (local.get $offset)
                    (i32.mul (local.get $j) (i32.const 4))
                  )
                )
              )
              (i32.store
                (i32.add
                  (local.get $offset)
                  (i32.mul (local.get $j) (i32.const 4))
                )
                (local.get $temp)
              )
              (local.set $i (i32.add (local.get $i) (i32.const 1)))
            )
          )
          (local.set $j (i32.add (local.get $j) (i32.const 1)))
          (br $partition_loop)
        )
      )
    )
    
    ;; 交换 arr[i] 和 arr[right]（pivot）
    (local.set $temp
      (i32.load
        (i32.add
          (local.get $offset)
          (i32.mul (local.get $i) (i32.const 4))
        )
      )
    )
    (i32.store
      (i32.add
        (local.get $offset)
        (i32.mul (local.get $i) (i32.const 4))
      )
      (i32.load
        (i32.add
          (local.get $offset)
          (i32.mul (local.get $right) (i32.const 4))
        )
      )
    )
    (i32.store
      (i32.add
        (local.get $offset)
        (i32.mul (local.get $right) (i32.const 4))
      )
      (local.get $temp)
    )
    
    ;; 递归排序左右两部分
    (call $quicksort
      (local.get $offset)
      (local.get $left)
      (i32.sub (local.get $i) (i32.const 1))
    )
    (call $quicksort
      (local.get $offset)
      (i32.add (local.get $i) (i32.const 1))
      (local.get $right)
    )
  )
  
  ;; 导出快速排序函数
  ;; 参数：
  ;;   - offset: 数组在内存中的起始偏移量
  ;;   - length: 数组长度
  (func (export "quicksort") (param $offset i32) (param $length i32)
    (if (i32.gt_s (local.get $length) (i32.const 1))
      (then
        (call $quicksort
          (local.get $offset)
          (i32.const 0)
          (i32.sub (local.get $length) (i32.const 1))
        )
      )
    )
  )
  
  ;; 冒泡排序（用于对比）
  ;; 参数：
  ;;   - offset: 数组在内存中的起始偏移量
  ;;   - length: 数组长度
  (func (export "bubblesort") (param $offset i32) (param $length i32)
    (local $i i32)
    (local $j i32)
    (local $temp i32)
    (local $swapped i32)
    
    (local.set $i (i32.const 0))
    
    (loop $outer_loop
      (if (i32.lt_s (local.get $i) (local.get $length))
        (then
          (local.set $swapped (i32.const 0))
          (local.set $j (i32.const 0))
          
          (loop $inner_loop
            (if (i32.lt_s
                  (local.get $j)
                  (i32.sub (i32.sub (local.get $length) (local.get $i)) (i32.const 1))
                )
              (then
                ;; 比较 arr[j] 和 arr[j+1]
                (if (i32.gt_s
                      (i32.load
                        (i32.add
                          (local.get $offset)
                          (i32.mul (local.get $j) (i32.const 4))
                        )
                      )
                      (i32.load
                        (i32.add
                          (local.get $offset)
                          (i32.mul (i32.add (local.get $j) (i32.const 1)) (i32.const 4))
                        )
                      )
                    )
                  (then
                    ;; 交换
                    (local.set $temp
                      (i32.load
                        (i32.add
                          (local.get $offset)
                          (i32.mul (local.get $j) (i32.const 4))
                        )
                      )
                    )
                    (i32.store
                      (i32.add
                        (local.get $offset)
                        (i32.mul (local.get $j) (i32.const 4))
                      )
                      (i32.load
                        (i32.add
                          (local.get $offset)
                          (i32.mul (i32.add (local.get $j) (i32.const 1)) (i32.const 4))
                        )
                      )
                    )
                    (i32.store
                      (i32.add
                        (local.get $offset)
                        (i32.mul (i32.add (local.get $j) (i32.const 1)) (i32.const 4))
                      )
                      (local.get $temp)
                    )
                    (local.set $swapped (i32.const 1))
                  )
                )
                (local.set $j (i32.add (local.get $j) (i32.const 1)))
                (br $inner_loop)
              )
            )
          )
          
          ;; 如果没有交换，提前退出
          (if (i32.eqz (local.get $swapped))
            (then return)
          )
          
          (local.set $i (i32.add (local.get $i) (i32.const 1)))
          (br $outer_loop)
        )
      )
    )
  )
)

