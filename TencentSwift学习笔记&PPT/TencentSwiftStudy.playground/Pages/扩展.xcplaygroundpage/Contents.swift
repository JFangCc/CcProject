//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//扩展可以为枚举、结构体、类、协议添加新的功能
//类似OC的分类
extension Double {
    var km: Double { self / 1_000.0}
    var m: Double { self }
    var mm: Double { self * 1_000.0}
}

var d = 100.0
d.km
d.m
d.mm

var arr = [10, 20, 33]

extension Array {
    subscript(nullable idx: Int) -> Element? {
        if (startIndex..<endIndex).contains(idx){
            return self[idx]
        }
        return nil
    }
}

print(arr[nullable: 11] as Any)
print(arr[nullable: 10] ?? 0)

//为 遵守 BinaryInteger 协议的整数 扩展方法
func isOdd<T: BinaryInteger> (v1: T) -> Bool {
    v1 % 2 != 0
}
print(isOdd(v1: 3))


extension BinaryInteger {
    func isOdd() -> Bool {
        self % 2 != 0
    }
}
print(3.isOdd())

//扩展协议 已经实现原协议中的方法
//继承该协议的类 不须实现协议方法
protocol dsdsd {
    func isOdd() -> Bool
}

extension dsdsd {
    func isOdd() -> Bool {
        true
    }
}
