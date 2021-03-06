---
description: Golang 基础 - 基本数据类型
# 设置当前文章的发布时间
date: 2020-01-27 17:30
# 设置当前文章的分类
category: Study
# 设置当前文章的标签
tags:
  - Development
  - Study
  - Golang
---

# Golang-02 Basic Data Type

> `Golang` 语言基础 - 基本数据类型

[[toc]]

## 数字

### 整形

整形也就是 `Number`，分为有符号和无符号整形。

#### 无符号 与 有符号

计算机里的数是用二进制表示的，最左边的这一位一般用来表示这个数是正数还是负数，这样的话这个数就是有符号整数。此类整数可以表示正整数，又可以表示负整数。

如果最左边这一位不用来表示正负，而是和后面的连在一起表示整数，那么就不能区分这个数是正还是负，就只能是正数，这就是无符号整数。此类整数一定是正整数。

其中，uint8 就是我们熟知的 byte 型，int16 对应 C 语言中的 short 型，int64 对应 C 语言中的 long 型。

| 类型   | 描述                                                           |
| ------ | -------------------------------------------------------------- |
| uint8  | 无符号 8 位整型 (0 到 255)                                     |
| uint16 | 无符号 16 位整型 (0 到 65535)                                  |
| uint32 | 无符号 32 位整型 (0 到 4294967295)                             |
| uint64 | 无符号 64 位整型 (0 到 18446744073709551615)                   |
| int8   | 有符号 8 位整型 (-128 到 127)                                  |
| int16  | 有符号 16 位整型 (-32768 到 32767)                             |
| int32  | 有符号 32 位整型 (-2147483648 到 2147483647)                   |
| int64  | 有符号 64 位整型 (-9223372036854775808 到 9223372036854775807) |

#### 特殊整形

这几种整形长度不固定，取决于平台所支持的最大位数。

| 类型    | 描述                                                   |
| ------- | ------------------------------------------------------ |
| uint    | 32 位操作系统上就是 uint32，64 位操作系统上就是 uint64 |
| int     | 32 位操作系统上就是 int32，64 位操作系统上就是 int64   |
| uintptr | 无符号整型，用于存放一个指针                           |

#### 数字字面量

`Golang` 1.13 版本之后引入了数字字面量语法，这样便于开发者以二进制、八进制或十六进制浮点数的格式定义数字

- `v := 0b00101101`， 代表二进制的 101101，相当于十进制的 45。
- `v := 0o377`，代表八进制的 377，相当于十进制的 255。
- `v := 0x1p-2`，代表十六进制的 1 除以 2²，也就是 0.25。
- 而且还允许我们用 \_ 来分隔数字，比如说：v := 123_456 等于 123456。(千位分隔符)

```go
package main

import "fmt"

func main(){
  // 十进制
  var a int = 10
  fmt.Printf("%d \n", a)  // 10
  fmt.Printf("%b \n", a)  // 1010  占位符%b表示二进制

  // 八进制  以0开头
  var b int = 077
  fmt.Printf("%o \n", b)  // 77

  // 十六进制  以0x开头
  var c int = 0xff
  fmt.Printf("%x \n", c)  // ff
}
```

### 浮点型

浮点型 及 小数，`Golang` 支持两种浮点型数：`float32` 和 `float64`。

这两种浮点型数据格式遵循 IEEE 754 标准

- `float32` 的浮点数的最大范围约为 3.4e38，可以使用常量定义：`math.MaxFloat32`。
- `float64` 的浮点数的最大范围约为 1.8e308，可以使用一个常量定义：`math.MaxFloat64`。

打印浮点数时，可以使用 `fmt` 包配合动词 `%f`，代码如下：

```go
package main
import (
  "fmt"
  "math"
)
func main() {
  fmt.Printf("%f\n", math.Pi) // %f 默认保留6位小数
  fmt.Printf("%.2f\n", math.Pi) // .2 表示保留2位小数
}
```

### 复数

复数有实部和虚部，`complex64` 的实部和虚部为 32 位，`complex128` 的实部和虚部为 64 位。

```go
var c1 complex64
c1 = 1 + 2i
var c2 complex128
c2 = 2 + 3i
fmt.Println(c1)
fmt.Println(c2)
```

## 布尔值

`Golang` 中通过 `bool` 类型进行声明布尔类型数据，布尔类型数据只有 `true`（真）和 `false`（假）两个值。

- 布尔类型变量的默认值为 `false`。
- `Golang` 中 不允许 将 整型 强制转换为 布尔型。
- 布尔型无法参与数值运算，也无法与其他类型进行转换。

## 字符串

`Golang` 中通过 `string` 类型进行声明字符串类型数据，字符串类型的内部实现使用 UTF-8 编码。字符串的值为 `""` 中的内容，单引号包裹的并不是字符串。

### 字符串转义符

| 转义符 | 含义                               |
| ------ | ---------------------------------- |
| \r     | 回车符（返回行首）                 |
| \n     | 换行符（直接跳到下一行的同列位置） |
| \t     | 制表符                             |
| \'     | 单引号                             |
| \"     | 双引号                             |
| \\     | 反斜杠                             |

```go
// 打印一个 Windows 平台下的一个文件路径
package main
import "fmt"
func main() {
  fmt.Println("str := \"c:\\Code\\lesson1\\go.exe\"")
}
```

### 多行字符串

`Golang` 中可通过 `` 定义一个多行字符串，反引号间换行将被作为字符串中的换行，但是所有的转义字符均无效，文本将会原样输出。

```go
s1 := `第一行
第二行
第三行
`
fmt.Println(s1)
```

### 修改字符串

要修改字符串，需要先将其转换成 `[]rune` 或 `[]byte`，完成后再转换为 `string`。无论哪种转换，都会重新分配内存，并复制字节数组。

```go
func changeString() {
  s1 := "big"
  // 强制类型转换
  byteS1 := []byte(s1)
  byteS1[0] = 'p'
  fmt.Println(string(byteS1))

  s2 := "白萝卜"
  runeS2 := []rune(s2)
  runeS2[0] = '红'
  fmt.Println(string(runeS2))
}
```

### 字符串的常用操作

| 方法                                     | 介绍                              |
| ---------------------------------------- | --------------------------------- |
| `len(str)`                               | 求长度 +或 fmt.Sprintf 拼接字符串 |
| `strings.Split`                          | 分割                              |
| `strings.contains`                       | 判断是否包含                      |
| `strings.HasPrefix`, `strings.HasSuffix` | 前缀/后缀判断                     |
| `strings.Index`, `strings.LastIndex`     | 子串出现的位置                    |
| `strings.Join`                           | join 操作                         |

## byte 和 rune

组成每个字符串的元素叫做“字符”，可以通过遍历或者单个获取字符串元素获得字符。 字符使用单引号 `''` 包裹。

```go
var a := '中'
var b := 'x'
```

`Golang` 中字符有两种

- `uint8` 类型，或者叫 `byte` 型，代表了 `ASCII码` 的一个字符。
- `rune` 类型，代表一个 `UTF-8` 字符。

当需要处理中文、日文或者其他复合字符时，则需要用到 `rune` 类型，`rune` 类型实际是一个 int32。

```go
// 遍历字符串
func traversalString() {
  s := "hello沙河"

  // byte
  for i := 0; i < len(s); i++ {
    fmt.Printf("%v(%c) ", s[i], s[i])
  }
  fmt.Println()

  // rune
  for _, r := range s { //rune
    fmt.Printf("%v(%c) ", r, r)
  }
  fmt.Println()
}

// 输出：
// 104(h) 101(e) 108(l) 108(l) 111(o) 230(æ) 178(²) 153() 230(æ) 178(²) 179(³)
// 104(h) 101(e) 108(l) 108(l) 111(o) 27801(沙) 27827(河)
```

> 因为 UTF8 编码下一个中文汉字由 3~4 个字节组成，所以我们不能简单的按照字节去遍历一个包含中文的字符串，否则就会出现上面输出中第一行的结果。

字符串底层是一个 `byte` 数组，所以可以和 `[]byte` 类型相互转换。

字符串是不能修改的 字符串是由 `byte` 字节组成，所以字符串的长度是 `byte` 字节的长度。 `rune` 类型用来表示 utf8 字符，一个 `rune` 字符由一个或多个 `byte` 组成。

## 类型转换

在 `Golang` 中只有强制类型转换，没有隐式类型转换。该语法只能在两个类型之间支持相互转换的时候使用。

强制类型转换的基本语法如下，其中，`T` 表示要转换的类型。表达式包括变量、复杂算子和函数返回值等。

```go
T(表达式)
```

计算直角三角形的斜边长时使用 `math` 包的 `Sqrt()` 函数，该函数接收的是 `float64` 类型的参数，而变量 `a` 和 `b` 都是 `int` 类型的，这个时候就需要将 `a` 和 `b` 强制类型转换为 `float64` 类型。

```go
func sqrtDemo() {
  var a, b = 3, 4
  var c int
  // math.Sqrt()接收的参数是float64类型，需要强制转换
  c = int(math.Sqrt(float64(a*a + b*b)))
  fmt.Println(c)
}
```
