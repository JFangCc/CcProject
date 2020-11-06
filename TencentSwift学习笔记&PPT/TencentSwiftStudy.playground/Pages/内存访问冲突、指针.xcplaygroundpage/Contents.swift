//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

do {
    var v = 0
}

do {
    var v = 0
}

var step = 1
var step1 = step
func increment(_ num: inout Int) {
    num += step
}
increment(&step1)
step = step1
print(step)

//指针
var age = 10
func test1(_ ptr: UnsafeMutablePointer<Int>){
    ptr.pointee = 20
}
func test2(_ ptr: UnsafePointer<Int>){
    ptr.pointee
    print(ptr.pointee)
}

//非泛型指针
func test3(_ ptr: UnsafeRawPointer){
    //取数据
    print(ptr.load(as: Int.self))
}
func test4(_ ptr: UnsafeMutableRawPointer){
    //存数据
    ptr.storeBytes(of: 40, as: Int.self)
}

test1(&age)
test2(&age)
test3(&age)
test4(&age)
print(age)

//数组遍历
var arr = NSArray(objects: 11,22,33,44)
arr.enumerateObjects { (ellment, idx, stop) in
    if idx == 2{
        stop.pointee = true
    }
    print(idx, ellment)
}

for (idx, element) in arr.enumerated() {
    print(idx,element)
    if(idx == 2){
        break
    }
}

//ptr: 指针
//获得变量的泛型指针
var ptr = withUnsafePointer(to: &age) { $0 }
var ptr2 = withUnsafeMutablePointer(to: &age) { $0 }
ptr2.pointee = 90
print(age)


var dsds = [Int: Int]()


