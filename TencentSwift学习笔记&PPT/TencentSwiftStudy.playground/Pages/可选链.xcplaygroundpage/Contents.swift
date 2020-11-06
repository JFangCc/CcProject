//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
class Person {
    func age() -> Int {
        18
    }
    subscript (index: Int) -> Int {
        index
    }
}

var p: Person? = Person()
var age = p?.age()
print(age)

var index = p?[0]
print(index)

var num: Int? = 0
num? = 9

var num1: Int? = nil
num1? = 9
print(num, num1)
