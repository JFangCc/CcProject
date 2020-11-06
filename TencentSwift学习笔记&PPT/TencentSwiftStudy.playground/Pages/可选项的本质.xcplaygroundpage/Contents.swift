//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//可选项本质是枚举类型
enum Optional<Wrapped> {
    case none
    case some(Wrapped)
}

var age: Optional<Int> = Optional.some(9)
var age1 = Optional<Int>.some(20)
var age2 = Optional.some(20)
var age3: Optional = .some(20)
var age4: Optional<Int> = .none
