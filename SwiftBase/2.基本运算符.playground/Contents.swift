import UIKit

var str = "Hello, playground"

//术语
///运算符分为一元、二元和三元运算符
///受运算符影响的值叫操作数，在表达式 1 + 2 中，加号 + 是二元运算符，它的两个操作数是值 1 和 2

//赋值运算符
let b = 11
var a = 4
a = b
print(a)

let (x,y) = (2,"eeee")
print(x,y)

///与 C 语言和 Objective-C 不同，Swift 的赋值操作并不返回任何值。所以下面语句是无效的：
//if x = y {
    // 此句错误，因为 x = y 并不返回任何值
//}

//算术运算符
//+，-，*，/
1 + 2       // 等于 3
5 - 3       // 等于 2
2 * 3       // 等于 6
10.0 / 2.5  // 等于 4.0

///加法运算符也可用于 String 的拼接
let aa = "aaa" + "bbb"
print(aa)

//求余运算符
///求余运算符（a % b）是计算 b 的多少倍刚刚好可以容入 a，返回多出来的那部分（余数）。
///求余运算符（%）在其他语言也叫取模运算符。但是严格说来，我们看该运算符对负数的操作结果，「求余」比「取模」更合适些。
let mod = 5 % 2
let mod1 = -5 % 2
print(mod,mod1)

///在对负数 b 求余时，b 的符号会被忽略。这意味着 a % b 和 a % -b 的结果是相同的。
let ddd = 8 % 3
let fff = 8 % -3
print(ddd,fff)

//组合赋值运算符
var asa = 2
asa+=2
print(asa)
///复合赋值运算没有返回值，let b = a += 2 这类代码是错误
let bb = asa+=2

//比较运算符
///每个比较运算都返回了一个标识表达式是否成立的布尔值：
//等于（a == b）
//不等于（a != b）
//大于（a > b）
//小于（a < b）
//大于等于（a >= b）
//小于等于（a <= b）

let ss = "wwww"
if ss == "ssss"{
    print("yes")
}else {
    print("no")
}

//元组比较
///如果两个元组的元素相同，且长度相同的话，元组就可以被比较。比较元组大小会按照从左到右、逐值比较的方式，直到发现有两个值不等时停止。如果所有的值都相等，那么这一对元组我们就称它们是相等的。
let yuan = (1,2,3)
let bvcv = (3,4,5)
if yuan == bvcv {
    print("yes")
}else {
    print("no")
}

let str1 = "fabc"
let str2 = "bcd"
if str1 > str2 {
    print("yes")
}else {
    print("no")
}

//存有布尔类型的元组不能被比较
///Swift 标准库只能比较七个以内元素的元组比较函数。如果你的元组元素超过七个时，你需要自己实现比较运算符。

//三元运算符
let contentHeight = 40
let hasHeader = false
let rowHeight = hasHeader ? contentHeight : 20
print(rowHeight)

//空合运算符
///针对可选类型变量/常量判断
let defaultc = "www"
var userde:String? = "sss"
var color = userde ?? defaultc
var color1 = userde != nil ? userde! : defaultc
print(color,color1)

//区间运算符
///闭区间运算符（a...b）定义一个包含从 a 到 b（包括 a 和 b）的所有值的区间。a 的值不能超过 b。
for index in 1...5 {
    print(index)
}
//半开区间运算符
///半开区间运算符（a..<b）定义一个从 a 到 b 但不包括 b 的区间。 之所以称为半开区间，是因为该区间包含第一个值而不包括最后的值。

let bbb = ["sdsd","dsdsd","sdwdw"]
for index in 0..<bbb.count {
    print(bbb[index])
}

//单侧区间
for index in bbb[..<3] {
    print(index)
}

let range = 1...bbb.count
let vcv = range.contains(0)
let vcv1 = range.contains(1)
let vcv2 = range.contains(2)
let vcv3 = range.contains(3)
let vcv4 = range.contains(4)
print(vcv,vcv1,vcv2,vcv3,vcv4)

//逻辑运算符
//逻辑非（!a）
//逻辑与（a && b）
//逻辑或（a || b）
///Swift 逻辑操作符 && 和 || 是左结合的，这意味着拥有多元逻辑操作符的复合表达式优先计算最左边的子表达式。
let sdsw = true;
let erew = false;
if sdsw || erew || erew {
    print("yes")
}else {
    print("no")
}

//使用括号来明确优先级
if sdsw && (sdsw || erew) {
    print("yes")
}else {
    print("no")
}



