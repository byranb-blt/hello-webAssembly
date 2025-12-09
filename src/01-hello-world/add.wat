;; Hello World 示例 - 简单的加法函数
;; 演示基本的函数定义、参数、返回值和导出

(module
  ;; 定义一个加法函数
  ;; 参数：两个i32类型的整数
  ;; 返回值：i32类型的整数
  (func $add (param $lhs i32) (param $rhs i32) (result i32)
    ;; 获取第一个参数
    local.get $lhs
    ;; 获取第二个参数
    local.get $rhs
    ;; 执行加法运算
    i32.add
  )
  
  ;; 导出函数，使其可以从JavaScript调用
  ;; 导出名为 "add"，对应内部函数 $add
  (export "add" (func $add))
  
  ;; 定义一个返回常量的函数
  (func $getAnswer (result i32)
    i32.const 42
  )
  
  ;; 导出常量函数
  (export "getAnswer" (func $getAnswer))
  
  ;; 定义一个返回 "getAnswer + 1" 的函数
  (func (export "getAnswerPlus1") (result i32)
    call $getAnswer
    i32.const 1
    i32.add
  )
)

