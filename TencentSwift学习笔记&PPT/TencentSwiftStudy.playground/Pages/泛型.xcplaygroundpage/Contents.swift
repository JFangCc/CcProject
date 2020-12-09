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

//不透明类型 some

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
