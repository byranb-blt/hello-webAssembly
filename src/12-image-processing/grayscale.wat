;; 图片灰度处理 - WebAssembly 实现
;; 对比 JavaScript Canvas 和 WebAssembly 的性能

(module
  ;; 导入内存
  (import "js" "mem" (memory 1))
  
  ;; 导出函数：灰度处理
  ;; 参数：
  ;;   - offset: 图像数据在内存中的偏移量
  ;;   - length: 图像数据的长度（像素数 * 4，RGBA）
  ;; 算法：Gray = 0.299*R + 0.587*G + 0.114*B
  (func (export "grayscale") (param $offset i32) (param $length i32)
    (local $i i32)
    (local $r i32)
    (local $g i32)
    (local $b i32)
    (local $gray i32)
    
    ;; 初始化循环变量
    (local.set $i (i32.const 0))
    
    ;; 循环处理每个像素
    (loop $loop
      ;; 检查是否处理完所有像素
      (if (i32.lt_u (local.get $i) (local.get $length))
        (then
          ;; 读取 R, G, B 值（跳过 Alpha 通道）
          (local.set $r (i32.load8_u (i32.add (local.get $offset) (local.get $i))))
          (local.set $g (i32.load8_u (i32.add (i32.add (local.get $offset) (local.get $i)) (i32.const 1))))
          (local.set $b (i32.load8_u (i32.add (i32.add (local.get $offset) (local.get $i)) (i32.const 2))))
          
          ;; 计算灰度值: Gray = 0.299*R + 0.587*G + 0.114*B
          ;; 使用整数运算避免浮点数开销
          ;; Gray = (299*R + 587*G + 114*B) / 1000
          (local.set $gray
            (i32.div_u
              (i32.add
                (i32.add
                  (i32.mul (local.get $r) (i32.const 299))
                  (i32.mul (local.get $g) (i32.const 587))
                )
                (i32.mul (local.get $b) (i32.const 114))
              )
              (i32.const 1000)
            )
          )
          
          ;; 将灰度值写入 R, G, B 通道（保持 Alpha 不变）
          (i32.store8 (i32.add (local.get $offset) (local.get $i)) (local.get $gray))
          (i32.store8 (i32.add (i32.add (local.get $offset) (local.get $i)) (i32.const 1)) (local.get $gray))
          (i32.store8 (i32.add (i32.add (local.get $offset) (local.get $i)) (i32.const 2)) (local.get $gray))
          
          ;; i += 4 (下一个像素，RGBA)
          (local.set $i (i32.add (local.get $i) (i32.const 4)))
          
          ;; 继续循环
          (br $loop)
        )
      )
    )
  )
  
  ;; 导出函数：快速灰度处理（使用移位优化）
  ;; 算法：Gray = (R*77 + G*150 + B*29) >> 8
  (func (export "grayscale_fast") (param $offset i32) (param $length i32)
    (local $i i32)
    (local $r i32)
    (local $g i32)
    (local $b i32)
    (local $gray i32)
    
    (local.set $i (i32.const 0))
    
    (loop $loop
      (if (i32.lt_u (local.get $i) (local.get $length))
        (then
          ;; 读取 RGB 值
          (local.set $r (i32.load8_u (i32.add (local.get $offset) (local.get $i))))
          (local.set $g (i32.load8_u (i32.add (i32.add (local.get $offset) (local.get $i)) (i32.const 1))))
          (local.set $b (i32.load8_u (i32.add (i32.add (local.get $offset) (local.get $i)) (i32.const 2))))
          
          ;; 快速灰度计算: Gray = (R*77 + G*150 + B*29) >> 8
          (local.set $gray
            (i32.shr_u
              (i32.add
                (i32.add
                  (i32.mul (local.get $r) (i32.const 77))
                  (i32.mul (local.get $g) (i32.const 150))
                )
                (i32.mul (local.get $b) (i32.const 29))
              )
              (i32.const 8)
            )
          )
          
          ;; 写入灰度值
          (i32.store8 (i32.add (local.get $offset) (local.get $i)) (local.get $gray))
          (i32.store8 (i32.add (i32.add (local.get $offset) (local.get $i)) (i32.const 1)) (local.get $gray))
          (i32.store8 (i32.add (i32.add (local.get $offset) (local.get $i)) (i32.const 2)) (local.get $gray))
          
          ;; 下一个像素
          (local.set $i (i32.add (local.get $i) (i32.const 4)))
          (br $loop)
        )
      )
    )
  )
)

