//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//可选项本质是枚举类型
enum Optional<T> {
    case none
    case some(T)
}

var age: Optional<Int> = Optional.some(9)
var age1 = Optional<String>.some("20")
var age2 = Optional.some(20)
var age3: Optional = .some(20)
var age4: Optional<Int> = .none


enum ooooppp {
    case no
    case some(String)
}

let op = ooooppp.some("jing")
let sd = ooooppp.self
print(sd)

var dddddd: AnyObject = op as AnyObject
print(dddddd)



