;; 内存操作示例 - 字符串传递
;; 演示 JavaScript 和 WebAssembly 之间的内存共享

(module
  ;; 导入内存（从 JavaScript 传入）
  ;; 1 表示至少需要 1 页内存（64KB）
  (import "js" "mem" (memory 1))
  
  ;; 导入日志函数（从 JavaScript 传入）
  ;; 参数：字符串在内存中的偏移量和长度
  (import "console" "log" (func $log (param i32 i32)))
  
  ;; 在内存偏移 0 处写入字符串 "Hello, WebAssembly!"
  ;; data 段在模块实例化时初始化
  (data (i32.const 0) "Hello, WebAssembly!")
  
  ;; 导出函数，供 JavaScript 调用
  ;; 调用日志函数，传递字符串的位置和长度
  (func (export "writeHi")
    i32.const 0   ;; 字符串偏移量：0
    i32.const 20  ;; 字符串长度：20 字节
    call $log     ;; 调用导入的日志函数
  )
  
  ;; 另一个示例：写入多个字符串
  (data (i32.const 100) "First string")
  (data (i32.const 120) "Second string")
  
  ;; 导出函数：写入第一个字符串
  (func (export "writeFirst")
    i32.const 100
    i32.const 13
    call $log
  )
  
  ;; 导出函数：写入第二个字符串
  (func (export "writeSecond")
    i32.const 120
    i32.const 13
    call $log
  )
  
  ;; 示例：在内存中存储数字
  ;; 导出函数：设置内存中的数字
  (func (export "setNumber") (param $value i32)
    ;; 在内存偏移 200 处存储数字
    (i32.store (i32.const 200) (local.get $value))
  )
  
  ;; 导出函数：获取内存中的数字
  (func (export "getNumber") (result i32)
    ;; 从内存偏移 200 处读取数字
    (i32.load (i32.const 200))
  )
)

