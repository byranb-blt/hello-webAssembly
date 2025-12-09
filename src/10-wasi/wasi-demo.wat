;; WASI (WebAssembly System Interface) 演示示例
;; 演示如何在 WebAssembly 中使用 WASI 接口

(module
  ;; 导入 WASI 的 fd_write 函数
  ;; fd_write 用于写入文件描述符（如 stdout、stderr）
  ;; 参数：
  ;;   - i32: file_descriptor (文件描述符，1 = stdout, 2 = stderr)
  ;;   - i32: *iovs (io vector 数组的指针)
  ;;   - i32: iovs_len (io vector 数组的长度)
  ;;   - i32: *nwritten (写入字节数的指针，用于返回结果)
  ;; 返回值：i32 (错误码，0 表示成功)
  (import "wasi_unstable" "fd_write" 
    (func $fd_write (param i32 i32 i32 i32) (result i32)))
  
  ;; 定义内存（1 页 = 64KB）
  (memory 1)
  ;; 导出内存，供外部访问
  (export "memory" (memory 0))
  
  ;; 在内存中写入字符串数据
  ;; 偏移 8: "Hello from WASI!\n"
  (data (i32.const 8) "Hello from WASI!\n")
  
  ;; 偏移 32: "This is a WASI demo.\n"
  (data (i32.const 32) "This is a WASI demo.\n")
  
  ;; 偏移 64: "WebAssembly System Interface\n"
  (data (i32.const 64) "WebAssembly System Interface\n")
  
  ;; 主函数（独立程序的入口点）
  ;; _start 是 WASI 程序的入口点，类似于 C 语言的 main 函数
  (func $main (export "_start")
    ;; 写入第一条消息
    ;; 创建 io vector 结构（在内存偏移 0 处）
    ;; io vector 结构：
    ;;   - offset 0-3: iov.iov_base (数据指针，4字节)
    ;;   - offset 4-7: iov.iov_len (数据长度，4字节)
    (i32.store (i32.const 0) (i32.const 8))   ;; iov.iov_base = 8 (字符串偏移)
    (i32.store (i32.const 4) (i32.const 18))  ;; iov.iov_len = 18 (字符串长度)
    
    ;; 调用 fd_write
    (call $fd_write
      (i32.const 1)   ;; file_descriptor = 1 (stdout)
      (i32.const 0)   ;; *iovs = 0 (io vector 数组的指针)
      (i32.const 1)   ;; iovs_len = 1 (只有一个 io vector)
      (i32.const 100) ;; *nwritten = 100 (写入字节数的指针，用于返回结果)
    )
    drop  ;; 忽略返回值（错误码）
    
    ;; 写入第二条消息
    (i32.store (i32.const 0) (i32.const 32))  ;; iov.iov_base = 32
    (i32.store (i32.const 4) (i32.const 22))  ;; iov.iov_len = 22
    (call $fd_write
      (i32.const 1)
      (i32.const 0)
      (i32.const 1)
      (i32.const 100)
    )
    drop
    
    ;; 写入第三条消息
    (i32.store (i32.const 0) (i32.const 64))  ;; iov.iov_base = 64
    (i32.store (i32.const 4) (i32.const 30))  ;; iov.iov_len = 30
    (call $fd_write
      (i32.const 1)
      (i32.const 0)
      (i32.const 1)
      (i32.const 100)
    )
    drop
  )
  
  ;; 导出函数：写入自定义消息
  ;; 这个函数可以在浏览器环境中被调用
  (func (export "writeMessage") (param $offset i32) (param $length i32)
    ;; 创建 io vector
    (i32.store (i32.const 0) (local.get $offset))
    (i32.store (i32.const 4) (local.get $length))
    
    ;; 调用 fd_write
    (call $fd_write
      (i32.const 1)   ;; stdout
      (i32.const 0)   ;; *iovs
      (i32.const 1)   ;; iovs_len
      (i32.const 100) ;; *nwritten
    )
    drop
  )
  
  ;; 导出函数：写入到 stderr
  (func (export "writeError") (param $offset i32) (param $length i32)
    ;; 创建 io vector
    (i32.store (i32.const 0) (local.get $offset))
    (i32.store (i32.const 4) (local.get $length))
    
    ;; 调用 fd_write，使用 stderr (文件描述符 2)
    (call $fd_write
      (i32.const 2)   ;; stderr
      (i32.const 0)   ;; *iovs
      (i32.const 1)   ;; iovs_len
      (i32.const 100) ;; *nwritten
    )
    drop
  )
)

