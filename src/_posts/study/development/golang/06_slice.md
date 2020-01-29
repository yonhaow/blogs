---
description: Golang 基础 - 切片
# 设置当前文章的发布时间
date: 2020-01-29 17:15
# 设置当前文章的分类
category: Study
# 设置当前文章的标签
tags:
  - Development
  - Study
  - Golang
---

# Golang-06 Slice

> `Golang` 语言基础 - 切片

[[toc]]

## 数组的问题

因为数组的长度是固定的并且数组长度属于类型的一部分，所以数组有很多的局限性。

- 这个求和函数只能处理 `[3]int` 类型，其他的都不支持。

```go
func arraySum(x [3]int) int{
    sum := 0
    for _, v := range x{
        sum = sum + v
    }
    return sum
}
```

- 数组 `a` 中已经有三个元素了，我们不能再继续往数组 `a` 中添加新元素了。

```go
a := [3]int{1, 2, 3}
```

## 切片与数组的区别

切片 是一个拥有相同类型元素的可变长度的序列，一般用于快速地操作一块数据集合。

- 它是基于数组类型做的一层封装。
- 它非常灵活，支持自动扩容。
- 切片是一个引用类型，它的内部结构包含地址、长度和容量。

## 切片的长度和容量

切片拥有自己的长度和容量，可以通过使用内置的 `len()` 函数求长度，使用内置的 `cap()` 函数求切片的容量。

## 切片的定义

切片的声明方式与数组类似，不需要定义元素长度。

```go
var 变量名和 []元素类型
```

```go
func main() {
  // 声明切片类型
  var a []string              // 声明一个字符串切片
  var b = []int{}             // 声明一个整型切片并初始化
  var c = []bool{false, true} // 声明一个布尔切片并初始化

  fmt.Println(a)              // []
  fmt.Println(b)              // []
  fmt.Println(c)              // [false true]

  fmt.Println(a == nil)       // true
  fmt.Println(b == nil)       // false
  fmt.Println(c == nil)       // false

  // fmt.Println(c == d)   // 切片是引用类型，不支持直接比较，只能和 nil 比较
}
```

## 基于数组定义切片

由于切片的底层就是一个数组，所以可以基于数组定义切片。

```go
func main() {
  // 基于数组定义切片

  // 定义一个数组
  a := [5]int{55, 56, 57, 58, 59}

  //基于数组a创建切片，

  // 截取原数组下标1-4(不包含4)的元素
  b := a[1:4] // [56 57 58]

  // 截取原数组下标1-end的元素
  c := a[1:] // [56 57 58 59]

  // 截取原数组下标0-4(不包含4)的元素
  d := a[:4] // [55 56 57 58]

  // 截取原数组所有的元素
  e := a[:]  // [55 56 57 58 59]

  fmt.Printf("type of b:%T\n", b) // type of b:[]int
}
```

## 基于切片定义切片

除了基于数组得到切片，还可以通过切片来得到切片。

::: warning
注意： 对切片进行再切片时，索引不能超过原数组的长度，否则会出现索引越界的错误。
:::

```go
func main() {
  // 切片再切片

  // 声明一个数组
  a := [...]string{"北京", "上海", "广州", "深圳", "成都", "重庆"}
  fmt.Printf("a:%v type:%T len:%d  cap:%d\n", a, a, len(a), cap(a))
  // => a:[北京 上海 广州 深圳 成都 重庆] type:[6]string len:6  cap:6

  // 基于数组定义切片
  b := a[1:3]
  fmt.Printf("b:%v type:%T len:%d  cap:%d\n", b, b, len(b), cap(b))
  // => b:[上海 广州] type:[]string len:2  cap:5

  // 基于切片定义切片
  c := b[1:5]
  fmt.Printf("c:%v type:%T len:%d  cap:%d\n", c, c, len(c), cap(c))
  // => c:[广州 深圳 成都 重庆] type:[]string len:4  cap:4
}
```

## 通过 make() 定义切片

我们上面都是基于数组来创建的切片，如果需要动态的创建一个切片，我们就需要使用内置的 make()函数，格式如下：

```go
var slice = make([]`T 元素类型`, `size 切片中元素的数量`, `cap 切片的容量`)
```

```go
func main() {
  a := make([]int, 2, 10)
  fmt.Println(a)      //[0 0]
  fmt.Println(len(a)) //2
  fmt.Println(cap(a)) //10
}
```

上面代码中 a 的内部存储空间已经分配了 10 个，但实际上只用了 2 个。 容量并不会影响当前元素的个数，所以 `len(a)` 返回 2，`cap(a)` 则返回该切片的容量。

## 切片的本质

切片的本质就是对底层数组的封装，它包含了三个信息：底层数组的指针、切片的长度（len）和切片的容量（cap）。

举个例子，现在有一个数组 `a := [8]int{0, 1, 2, 3, 4, 5, 6, 7}`，切片 `s1 := a[:5]`，相应示意图如下。

![切片的本质1](https://i.loli.net/2020/01/29/sPikFQTdvlrypcC.png)

切片 `s2 := a[3:6]`，相应示意图如下：

![切片的本质2](https://i.loli.net/2020/01/29/ifYTBlV8e9EkJDy.png)

## 切片不能直接比较

切片之间是不能比较的，我们不能使用 `==` 操作符来判断两个切片是否含有全部相等元素。

切片唯一合法的比较操作是和 `nil`(非基础类型默认值) 比较。

var s1 []int // len(s1)=0; cap(s1)=0; s1==nil
一个 `nil` 值的切片并没有底层数组，一个 `nil` 值的切片的长度和容量都是 0。但长度和容量都是 0 的切片一定是 `nil`，如下示例

```go
s2 := []int{}        // len(s2)=0; cap(s2)=0; s2!=nil
s3 := make([]int, 0) // len(s3)=0; cap(s3)=0; s3!=nil
```

所以要判断一个切片是否是空的，要是用 `len(s) == 0` 来判断，不应该使用 `s == nil` 来判断。

## 切片的拷贝与复制

因为切片是基于底层数组的引用值，所以如果两个切片是基于一个底层数组，那么对一个切片的修改也会影响另一个切片的内容。

```go
func main() {
  s1 := make([]int, 3) // [0 0 0]
  s2 := s1             // 将s1直接赋值给s2，s1和s2共用一个底层数组
  s2[0] = 100
  fmt.Println(s1) // [100 0 0]
  fmt.Println(s2) // [100 0 0]
}
```

`Golang` 内建的 `copy()` 函数可以迅速地将一个切片的数据复制到另外一个切片空间中，`copy()` 函数的使用格式如下：

```go
copy(`destSlice 需要赋值的切片`, `srcSlice 源数据切片`)
```

```go
func main() {
  // copy()复制切片
  a := []int{1, 2, 3, 4, 5}
  c := make([]int, 5, 5)

  copy(c, a)     // 使用copy()函数将切片a中的元素复制到切片c

  fmt.Println(a) // [1 2 3 4 5]
  fmt.Println(c) // [1 2 3 4 5]

  c[0] = 1000

  fmt.Println(a) // [1 2 3 4 5]
  fmt.Println(c) // [1000 2 3 4 5]
}
```

## 切片遍历

切片的遍历方式和数组是一致的，支持索引遍历和 `for range` 遍历。

```go
func main() {
  s := []int{1, 3, 5}

  // 索引遍历
  for i := 0; i < len(s); i++ {
    fmt.Println(i, s[i])
  }

  // range遍历
  for index, value := range s {
    fmt.Println(index, value)
  }
}
```

## 切片添加元素

`Golang` 的内建函数 `append()` 可以为切片动态添加元素。

每个切片会指向一个底层数组，这个数组的容量够用就添加新增元素。当底层数组不能容纳新增的元素时，切片就会自动按照一定的策略进行“扩容”，此时该切片指向的底层数组就会更换。

“扩容”操作往往发生在 `append()` 函数调用时，所以我们通常都需要用原变量接收 `append` 函数的返回值。

```go
func main() {
  // append()添加元素和切片扩容
  var numSlice []int

  for i := 0; i < 10; i++ {
    numSlice = append(numSlice, i)
    fmt.Printf("%v  len:%d  cap:%d  ptr:%p\n", numSlice, len(numSlice), cap(numSlice), numSlice)
  }

  // 输出：

  // [0]  len:1  cap:1  ptr:0xc0000a8000
  // [0 1]  len:2  cap:2  ptr:0xc0000a8040

  // [0 1 2]  len:3  cap:4  ptr:0xc0000b2020
  // [0 1 2 3]  len:4  cap:4  ptr:0xc0000b2020

  // [0 1 2 3 4]  len:5  cap:8  ptr:0xc0000b6000
  // [0 1 2 3 4 5]  len:6  cap:8  ptr:0xc0000b6000
  // [0 1 2 3 4 5 6]  len:7  cap:8  ptr:0xc0000b6000
  // [0 1 2 3 4 5 6 7]  len:8  cap:8  ptr:0xc0000b6000

  // [0 1 2 3 4 5 6 7 8]  len:9  cap:16  ptr:0xc0000b8000
  // [0 1 2 3 4 5 6 7 8 9]  len:10  cap:16  ptr:0xc0000b8000
}
```

从上面的结果可以看出：

`append()` 函数将元素追加到切片的最后并返回该切片。
切片 `numSlice` 的容量按照 1，2，4，8，16 这样的规则自动进行扩容，每次扩容后都是扩容前的 2 倍。

`append()` 函数还支持一次性追加多个元素。

```go
var citySlice []string

// 追加一个元素
citySlice = append(citySlice, "北京")

// 追加多个元素
citySlice = append(citySlice, "上海", "广州", "深圳")

// 追加切片
a := []string{"成都", "重庆"}
citySlice = append(citySlice, a...)

fmt.Println(citySlice) //[北京 上海 广州 深圳 成都 重庆]
```

## 切片的扩容策略

可以通过查看 `$GOROOT/src/runtime/slice.go` 源码，其中扩容相关代码如下：

```go
newcap := old.cap
doublecap := newcap + newcap
if cap > doublecap {
  newcap = cap
} else {
  if old.len < 1024 {
    newcap = doublecap
  } else {
    // Check 0 < newcap to detect overflow
    // and prevent an infinite loop.
    for 0 < newcap && newcap < cap {
      newcap += newcap / 4
    }
    // Set newcap to the requested cap when
    // the newcap calculation overflowed.
    if newcap <= 0 {
      newcap = cap
    }
  }
}
```

从上面的代码可以看出以下内容：

1. 首先判断，如果新申请容量（cap）大于 2 倍的旧容量（old.cap），最终容量（newcap）就是新申请的容量（cap）。
2. 否则判断，如果旧切片的长度小于 1024，则最终容量(newcap)就是旧容量(old.cap)的两倍，即（newcap=doublecap），
3. 否则判断，如果旧切片长度大于等于 1024，则最终容量（newcap）从旧容量（old.cap）开始循环增加原来的 1/4，即（newcap=old.cap,for {newcap += newcap/4}）直到最终容量（newcap）大于等于新申请的容量(cap)，即（newcap >= cap）
4. 如果最终容量（cap）计算值溢出，则最终容量（cap）就是新申请容量（cap）。

::: tip
需要注意的是，切片扩容还会根据切片中元素的类型不同而做不同的处理，比如 `int` 和 `string` 类型的处理方式就不一样。
:::

## 从切片中删除元素

`Golang` 中并没有删除切片元素的专用方法，我们可以使用切片本身的特性来删除元素。

```go
func main() {
  // 从切片中删除元素
  a := []int{30, 31, 32, 33, 34, 35, 36, 37}
  // 要删除索引为2的元素
  a = append(a[:2], a[3:]...)
  fmt.Println(a) // [30 31 33 34 35 36 37]
}
```

::: tip
要从切片 `a` 中删除索引为 `index` 的元素，操作方法是 `a = append(a[:index], a[index+1:]...)`
:::

## Exercise

- 请写出下面代码的输出结果。

```go
func main() {
  var a = make([]string, 5, 10)
  for i := 0; i < 10; i++ {
    a = append(a, fmt.Sprintf("%v", i))
  }
  fmt.Println(a)
}
```

- 请使用内置的 `sort` 包对数组 `var a = [...]int{3, 7, 8, 9, 1}` 进行排序（附加题，自行查资料解答）。
