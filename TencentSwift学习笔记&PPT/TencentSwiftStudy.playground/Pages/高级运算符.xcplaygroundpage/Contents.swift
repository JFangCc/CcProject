//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//溢出运算符
//&+ &- &*
var v1: UInt8 = UInt8.max
//v1 = 99999

var v2 = v1 &- 1
var v3 = v1 &* 2
print(v3)

struct Point {
    var x = 0, y = 0
    //运算符重载 必须static修饰
    static func + (point1: Point, point2: Point) -> Point {
        Point(x: point1.x + point2.x, y: point1.y + point2.y)
    }
    static func - (point1: Point, point2: Point) -> Point {
        Point(x: point1.x - point2.x, y: point1.y - point2.y)
    }
}

var p1 = Point(x: 10, y: 20)
var p2 = Point(x: 11, y: 22)
var p3 = Point(x: 22, y: 33)
let p4 = p1 + p2 + p3
let p5 = p1 - p2 - p3
print(p4, p5)


//Equatable 可比较协议
class Person: Equatable {
    var age: Int
    init(age: Int) {
        self.age = age
    }
    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.age == rhs.age
    }
}

var p6 = Person(age: 5)
var p7 = Person(age: 5)
print(p6 == p7)
print(p6 != p7)

//比较大小
//Comparable 协议
struct Point1: Comparable {
    var x = 0
    //运算符重载 static修饰
    static func > (point1: Point1, point2: Point1) -> Bool {
        point1.x > point2.x
    }
    static func < (point1: Point1, point2: Point1) -> Bool {
        point1.x < point2.x
    }
    static func >= (point1: Point1, point2: Point1) -> Bool {
        !(point1 < point2)
    }
    static func <= (point1: Point1, point2: Point1) -> Bool {
        !(point1 > point2)
    }
}

var p8 = Point1(x: 7)
var p9 = Point1(x: 8)

print(p8 < p9)
print(p8 == p9)
