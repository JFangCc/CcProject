//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//Method
//类型方法是不能访问实例属性的
class Car {
    //内存一直停留在程序中，类似全局变量
    static var count = 1
    static func getCount() -> Int {
        count
    }
}
Car.count = 8
print(Car.count)
print(Car.getCount())

//值类型（枚举、结构体）的属性是不能被自身实例方法所修改的
//若修改的话 实例方法加 mutating 关键字修饰方法

// @discardableResult 忽律方法返回值没使用的警告

