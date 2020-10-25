import UIKit

var str = "Hello, playground"

// 常量和变量
let num = 10
var f = 0.5
let x = 0, y = 1, z = 0.9
/// 可以在一行中声明多个常量或者多个变量，用逗号隔开
var m = "mmm", n = "nnn", o = "ooo"

//类型注解 type annotation
let ttt: NSString = "sss"
var current: NSString = "rrr"
var welcomeStr: NSString //声明一个类型为 String ，名字为 welcomeStr 的变量
welcomeStr = "2222"
var red, green, blue, purble:Float
var red1, green1, blue1, purble1:Double

//常量和变量的命名
let π = 3.1415926
let hello = "hello world"
let 🐶🐂 = "dogAndcow"
print("the π is \(π)")

// 这是一个注释
/*
 /*颠三倒四的时代*/
 这是一个多行注释
 */

//分号
let cat = "🐱"; print(cat)
 
//整数 - 可以是 有符号（正、负、零）或者 无符号（正、零）。
/// 42、-43
let min = UInt8.min //0 8位无符号类型
let max = Int32.max //32位有符号类型最大值

///(U)Int8/16/32/64 在32/64位平台上，Int和Int32/Int64 长度相同。

//浮点数
///Double 64位浮点数、当你需要存储很大或者很高精度的浮点数时请使用此类型
///Float 32位浮点数、精度要求不高的话可以使用此类型。

//类型安全和类型推断
let anotherPi =  3 + 0.14159
/// anotherPi 会被推测为 Double 类型
///原始值 3 没有显式声明类型，而表达式中出现了一个浮点字面量，所以表达式会被推断为 Double 类型。

//数值型类型转换
let unum: UInt8 = 1
///类型不能存储超过最大值的数
let big:Int8 = Int8.max - 1

let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)

//整数和浮点数转换
let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine
// pi 等于 3.14159，所以被推测为 Double 类型

//类型别名
typealias fangjing = UInt64
///定义了一个类型别名之后，你可以在任何使用原始名的地方使用别名：
let maxNum = fangjing.max

//布尔值
let redss = true;
let orange = false

if redss{
    print("red")
}else if orange {
    print("orange")
}else{
    print("1111")
}

//元组 元组（tuples）把多个值组合成一个复合值。元组内的值可以是任意类型，并不要求是相同类型。
let tup = ("sss", 0, 0.30, "404")
let (aaa, sss, fff, dddd) = tup
print("aaa is \(aaa)")

let (ggg,_,_,_) = tup
print(ggg)
print("\(tup.0)")

let ccc = tup
print(ccc.3)
print(tup.2)

let http404Error = (404, "Not Found")
// http404Error 的类型是 (Int, String)，值是 (404, "Not Found")
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
// 输出“The status code is 404”
print("The status message is \(statusMessage)")
// 输出“The status message is Not Found”

let wwww = (ddd:300,str:"ok")
if print(wwww.ddd) == print("\(wwww.ddd)") {
    print("yes")
}

//可选类型
let possibleNum = "123"
let convertNum = Int(possibleNum)
///convertNum 被推测为类型 "Int?"， 或者类型 "optional Int"
print(convertNum!)

var serverResponseCode:Int? = 404 /// serverResponseCode 包含一个可选的 Int 值 404
serverResponseCode = nil /// serverResponseCode 现在不包含值
var surveyAnswer: String? /// surveyAnswer 被自动设置为 nil

//在 Objective-C 中，nil 是一个指向不存在对象的指针。在 Swift 中，nil 不是指针——它是一个确定的值，用来表示值缺失。任何类型的可选状态都可以被设置为 nil，不只是对象类型。

//if 语句以及强制解析
if convertNum != nil {
    print("yes \(convertNum!)")
}else {
    print("no")
}

//可选绑定
if let actualNumber = convertNum {
    print(actualNumber)
}

if let asas = Int("333"), let dsds = Int("22") ,asas < dsds {
    print("\(asas) < \(dsds)")
}else {
    print("error")
}

if let wewew = Int("333") {
    if wewew > 12 {
        print("correct")
    }
}

let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // 需要感叹号来获取值

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString  // 不需要感叹号
print(implicitString)

if assumedString != nil {
    print(assumedString!)
}

if let dddss = assumedString {
    print(dddss)
}


let ddStr: String? = "wwwwww"
print(ddStr!)
//隐式解析可选类型
let ddStr1: String! = "eeeeee"
print(ddStr1!)

//错误处理
///当一个函数遇到错误条件，它能报错。调用函数的地方能抛出错误消息并合理处理。
func canThrowAnError() throws {
    ///这个函数有可能抛出错误
}

do {
    try canThrowAnError()
    // 没有错误消息抛出
} catch {
    // 有一个错误消息抛出
}













