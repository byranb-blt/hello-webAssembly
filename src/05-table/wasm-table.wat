;; Table 使用示例 - 函数指针
;; 演示如何使用 Table 实现函数指针和动态函数调用

(module
  ;; 创建一个表，初始大小为 2，元素类型为函数引用
  (table 2 funcref)
  
  ;; 定义第一个函数：返回 42
  (func $f1 (result i32)
    i32.const 42
  )
  
  ;; 定义第二个函数：返回 13
  (func $f2 (result i32)
    i32.const 13
  )
  
  ;; 使用 elem 段初始化表
  ;; 在索引 0 处放置 $f1，索引 1 处放置 $f2
  (elem (i32.const 0) $f1 $f2)
  
  ;; 定义函数类型（用于类型检查）
  (type $return_i32 (func (result i32)))
  
  ;; 导出函数：通过索引调用表中的函数
  ;; 这实现了函数指针的功能
  (func (export "callByIndex") (param $i i32) (result i32)
    local.get $i
    ;; 间接调用：从表中获取函数并调用
    call_indirect (type $return_i32)
  )
  
  ;; 导出表，供 JavaScript 访问
  (export "tbl" (table 0))
  
  ;; 定义更多函数用于演示
  (func $multiply_by_2 (param $x i32) (result i32)
    local.get $x
    i32.const 2
    i32.mul
  )
  
  (func $multiply_by_3 (param $x i32) (result i32)
    local.get $x
    i32.const 3
    i32.mul
  )
  
  ;; 定义接受参数的函数类型
  (type $i32_to_i32 (func (param i32) (result i32)))
  
  ;; 导出函数：通过索引调用带参数的函数
  (func (export "callWithParam") (param $index i32) (param $value i32) (result i32)
    local.get $value
    local.get $index
    ;; 注意：参数顺序是先压入函数参数，再压入索引
    call_indirect (type $i32_to_i32)
  )
  
  ;; 将新函数添加到表中（需要先扩展表）
  ;; 注意：在实际使用中，表的大小可能需要动态增长
)

