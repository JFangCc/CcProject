//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

var n1 = 10
var n2 = 20
func swapValues(_ a: inout Int, _ b: inout Int) {
    (a, b) = (b, a)
}
swapValues(&n1, &n2)
print(n1, n2)


func swapValues<T>(_ a: inout T, _ b: inout T) {
    (a, b) = (b, a)
}

var n3 = 10.0
var n4 = 20.0
swapValues(&n3, &n4)
print(n3, n4)


var fn:(inout Int, inout Int) -> () = swapValues
fn(&n1, &n2)
print(n1, n2)


class Stack<E> {
    var elements = [E]()
    func push(_ element: E) {
        elements.append(element)
    }
    func pop() -> E {
        elements.removeLast()
    }
}

var stack = Stack<Int>()
stack.push(8)
stack.push(9)
stack.pop()
print(stack.elements)


//枚举泛型
enum Score<T> {
    case score(T)
    case grade(String)
}

var score = Score.score(99)
var score1 = Score<Int>.grade("A")

//关联类型
//协议使用泛型方式
protocol Stackable {
    associatedtype T
    mutating func push(_ element: T)
    mutating func pop() -> T
}

class StringStack: Stackable {
    var elements = [String]()
    func push(_ element: String) {
        elements.append(element)
    }
    func pop() -> String {
        elements.removeLast()
    }
}

class StringStack1: Stackable {
    typealias T = String
    var elements = [T]()
    func push(_ element: T) {
        elements.append(element)
    }
    func pop() -> T {
        elements.removeLast()
    }
}

//类型约束
protocol Stackable1 {
    associatedtype T: Equatable
    var num: T { get }
    
}

//class Stack1<E: Equatable>: Stackable1 {
//    typealias T = E
//    var num: T {
//        T()
//    }
//}

class Stack2: Stackable1 {
    var num: Int {
        9
    }
}

//泛型
func firstIndex<T: Equatable>(of valueFind: T, in array: [T]) -> Int?{
    for(index, value) in array.enumerated(){
        if value == valueFind {
            return index
        }
    }
    return nil
}

let names = ["fangjing", "dsdsds", "efefe"]
let index = firstIndex(of: "fangjing", in: names)
print(index!)

let nums = [1, 2, 3]
let index1 = firstIndex(of: 2, in: nums)
print(index1!)

//不透明类型 some
protocol Shape {
    func draw() -> String
}

struct Triangle: Shape {
    var size: Int
    func draw() -> String {
        var result = [String]()
        for length in 1...size {
            result.append(String(repeating: "*", count: length))
        }
        return result.joined(separator: "\n")
    }
}

struct Square: Shape {
    var size: Int
    func draw() -> String {
        var result = [String]()
        for _ in 0...size {
            result.append(String(repeating: "*", count: size))
        }
        return result.joined(separator: "\n")
    }
}

struct FlippedShare<T: Shape> : Shape {
    var shape: T
    func draw() -> String {
        let result = shape.draw().split(separator: "\n")
        return result.reversed().joined(separator: "\n")
    }
}

struct JoinedShare<T: Shape, U: Shape> : Shape {
    var top: T
    var bottom: U
    func draw() -> String {
        return top.draw() + "\n" + bottom.draw()
    }
}

func makeTape() -> JoinedShare<Triangle, JoinedShare<Square, FlippedShare<Triangle>>>{
    let t = Triangle(size: 3)
    let s = Square(size: 3)
    let f = FlippedShare(shape: t)
    return JoinedShare(top: t, bottom: JoinedShare(top: s, bottom: f))
}

func makeTape1(size: Int) -> some Shape{
//    if size == 3 {
//        return Square(size: size)
//    }
    let t = Triangle(size: size)
    let s = Square(size: size)
    let f = FlippedShare(shape: t)
    return JoinedShare(top: t, bottom: JoinedShare(top: s, bottom: f))
}

let make = makeTape()
print(make.draw())

let make1 = makeTape1(size: 4)
print(make1.draw())

protocol Container {
    associatedtype item
    var count: Int {get}
    subscript (index: Int) -> item {get}
}

extension Array: Container{
    
}

func makePro<T>(item: T) -> some Container {
    [item]
}

print(makePro(item: "fang"))
