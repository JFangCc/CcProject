//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//柯里化

func add2(_ v1: Int, _ v2: Int, _ v3: Int) -> Int { v1 - v2 + v3 }

prefix func ~<A, B, C, D>(_ fn: @escaping (A, B, C) -> D) -> (C) -> (B) -> (A) ->(D) {
    { c in { b in { a in fn(a, b, c) } } }
}
print((~add2)(30)(20)(10))


//函子（Functor）
// Array、Optional 支持map运算的类型，称为函子
