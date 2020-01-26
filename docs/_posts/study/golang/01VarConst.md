---
description: Golang 基础 - 变量与常量
# 设置当前文章的发布时间
date: 2020-01-26 21:32
# 设置当前文章的分类
category: docs
# 设置当前文章的标签
tags:
  - Development
  - Study
  - Golang
---

# Golang-01 Golang Variable And Constant

> `Golang` 语言基础 - 变量和常量

[[toc]]

## 关键字

`Golang` 中有 25 个关键字：

```go
  break  default  func  interface  select
  case  defer  go  map  struct
  chan  else  goto  package  switch
  const  fallthrough  if  range  type
  continue  for  import  return  var
```

## 保留字

此外，在 `Golang` 语言中还有 37 个保留字。

```go
  Constants:  true  false  iota  nil

  Types:  int  int8  int16  int32  int64  uint  uint8  uint16  uint32  uint64  uintptr  float32  float64  complex128  complex64  bool  byte  rune  string  error

  Functions:  make  len  cap  new  append  copy  close  delete  complex  real  imag  panic  recover
```

## 变量

### 变量声明

变量声明以关键字 `var` 开头，变量类型放在变量的后面，行尾无需分号。

- 声明格式

```go
var 变量名 变量类型
```

#### 标准声明

```go
var name string
var age int
var isOk bool
```

#### 批量声明

```go
var (
  a string
  b int
  c bool
  d float32
)
```

### 变量初始化

#### 默认初始化

`Golang` 在声明变量的时候，会自动对变量对应的内存区域进行初始化操作。

每个变量会被初始化成其类型的默认值，例如：

| 变量类型       | 默认值 |
| -------------- | :----: |
| 整型/浮点型    |   0    |
| 字符串         |   ""   |
| 布尔           | false  |
| 切片/函数/指针 |  nil   |

#### 手动赋值

我们也可在声明变量的时候为其指定初始值。变量初始化的标准格式如下

```go
var 变量名 类型 = 表达式
```

```go
var name string = "123"
var age int = 18
```

#### 批量赋值

```go
var name, age = "123", 20
// => name = "123", age = 20
```

### 快速声明

在函数内部，可以使用更简略的 `:=` 方式声明并初始化变量。

```go
package main

import (
  "fmt"
)
// 全局变量m
var m = 100

func main() {
  m := 200 // 此处声明局部变量 m
  fmt.Println(m)
}
```

### 匿名变量

在使用多重赋值时，如果想要忽略某个值，可以使用 **匿名变量（anonymous variable）**。

匿名变量不占用命名空间，不会分配内存，所以匿名变量之间不存在重复声明。

匿名变量用一个下划线 `_` 表示

```go
func foo() (int, string) {
  return 10, "Q1mi"
}

func main() {
  x, _ := foo()
  _, y := foo()
  fmt.Println("x=", x)
  fmt.Println("y=", y)
}
```

### 类型推倒

有时候我们会将变量的类型省略，这个时候编译器会根据等号右边的值来推导变量的类型完成初始化。

```go
var name = "123"
var age = 18
```

## 常量

常量的声明和变量声明非常类似，只是把 `var` 换成了 `const`，**常量在定义时必须赋值**。

```go
// 标准声明
const pi = 3.1415
const e = 2.7182

// 批量声明
const (
    pi = 3.1415
    e = 2.7182
)
```

`const` 同时声明多个常量时，如果省略了值则表示和上面一行的值相同。 例如：

```go
const (
    n1 = 100
    n2
    n3
)
// n1 = n2 = n3 = 100
```

## iota

`iota` 是 `Golang` 的常量计数器，**只能在常量的表达式中使用**。

- `iota` 在 `const` 关键字出现时将被重置为 0。
- `const` 中每新增一行常量声明将使 `iota` 计数一次(`iota` 可理解为 `const` 语句块中的行索引)。

```go
const (
  n1 = iota // 0
  n2        // 1
  n3        // 2
  n4        // 3
)
```

### 常见用途

- 使用 `_` 跳过某些值

```go
const (
  n1 = iota // 0
  n2        // 1
  _
  n4        // 3
)
```

- 声明中间插队

```go
const (
  n1 = iota // 0
  n2 = 100  // 100
  n3 = iota // 2
  n4        // 3
)
const n5 = iota // 0
```

- 定义数量级

这里的<<表示左移操作，1<<10 表示将 1 的二进制表示向左移 10 位，也就是由 1 变成了 10000000000，也就是十进制的 1024。

同理 2<<2 表示将 2 的二进制表示向左移 2 位，也就是由 10 变成了 1000，也就是十进制的 8。）

```go
const (
  _  = iota
  KB = 1 << (10 * iota) // 即 乘以2的n次方，KB = 1*2^10 = 1024
  MB = 1 << (10 * iota)
  GB = 1 << (10 * iota)
  TB = 1 << (10 * iota)
  PB = 1 << (10 * iota)
)
```

- 多个 iota 定义在一行

```go
const (
  a, b = iota + 1, iota + 2 // 1, 2
  c, d                      // 2, 3
  e, f                      // 3, 4
)
```

## 注意事项

- 函数外的每个语句都必须以关键字开始（`var`, `const`, `func` 等）
- `:=` 不能使用在函数外。
- `_` 多用于占位，表示忽略值。
