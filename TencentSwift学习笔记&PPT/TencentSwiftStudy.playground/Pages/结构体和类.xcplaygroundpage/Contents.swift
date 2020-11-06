//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//方法(函数)是不占用实力对象内存的

struct Date {
    //存储属性
    var year: Int
    var month: Int
    var day: Int = 9
}
//初始化器
var date = Date(year: 2020, month: 10, day: 28)

//自定义初始化器
struct Point {
    var x: Int = 0
    var y: Int = 0
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

var point = Point(x: 5, y: 5)
print(point.x)

//结构体内存占用情况
print(MemoryLayout<Point>.size)//实际占用16
print(MemoryLayout<Point>.stride)//分配16
print(MemoryLayout<Point>.alignment)//对齐是8

//类
class ffff {
    var x: Int = 0
    var y: Int = 0
}
let ff = ffff()
print(ff.x)

//结构体和枚举是值类型，类是引用类型（指针类型）
//值类型赋值给var、let或者参数传参，是直接将所有内容拷贝一份副本 属于（深拷贝）
//当编译器发现有写的操作时，才会发生拷贝行为

//值类型 字符串、字典、数组、集合Set 都是结构体
let s1 = "aaa"
var s2 = s1
s2.append("bbb")
print(s1, s2)

print(ff,ffff.self)

//数组
func testSort() {
    var arr = [1,44,55,22,12]
    //排序闭包
//    arr.sort()
    arr.sort { (v1, v2) -> Bool in
        return v1 < v2
    }
    print(arr)
}
testSort()

