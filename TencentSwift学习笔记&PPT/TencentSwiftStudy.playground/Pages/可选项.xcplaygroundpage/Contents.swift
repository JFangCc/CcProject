//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//Optional
var name: String?//默认是nil
name = "ddd"
print(name)

//强制解包
print(name!)

enum fff: Int {
    case dd = 1, fffd, gggg, eee
}
if let dasas = fff(rawValue: 5) {
    print(dasas)
}else {
    print("no")
}
print(fff.fffd.rawValue)

//空合并运算符 ??
//返回值和 b、c 类型保持一致
// a ?? b    // a ?? b ?? c
// a是可选项，b是或不是
// a、b存储类型必须相同
// a不为nil 返回a，为nil 返回b
// a不为nil b非可选类型，返回强制解包a

//let a: Int? = 1
//let b: Int? = 2
//let c = a ?? b
//print(c)

//let a: Int? = nil
//let b: Int? = 2
//let c = a ?? b
//print(c)

//let a: Int? = nil
//let b: Int? = nil
//let c = a ?? b
//print(c)

let a: Int? = 1
let b: Int = 2
let c = a ?? b
print(c)

var dict = ["age": 10]
let age = dict["age"]

//guard 语法
//适合用来 提前退出
var num: Int? = nil
func method() {
    //用于方法内部
    guard let num1 = num else {
        print("exit")
        return
    }
    print(num1)
}
method()

//隐式解包
let nnn: Int! = 10
let nnn1: Int = nnn
print(nnn1)

var agea: Int? = nil
print("my age is \(agea ?? 0)")

//多重可选项
var ssssss: Int?? = agea
var ssssss1: Int?? = 10
print(ssssss, ssssss1, ssssss1!!)
//Optional(Optional(10)) Optional(Optional(10)) 10

