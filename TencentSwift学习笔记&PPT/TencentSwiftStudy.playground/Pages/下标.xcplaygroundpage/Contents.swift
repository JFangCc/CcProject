//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//下标 有 set 方法 必须有 get 方法
class test {
    var nums: [Int] = []
    subscript (index :Int) -> Int {
        get {
           return nums[index]
        }
        set {
            nums[index] = newValue
        }
    }
}
var t = test()
t.nums = [2,3,34,34,34,3,4]
print(t[2])
t[0] = 1111
print(t[0])

class sum {
    //类型下标
    static subscript (v1 :Int, v2 :Int) -> Int {
        get {
           return v1+v2
        }
        set {
        }
    }
}

print(sum[1,2])
sum[1,2] = 222
print(sum[1,2])


//结构体作为返回值
struct Point {
    var x = 10, y = 10
}

class PointManger {
    var point = Point()
    subscript (index: Int) -> Point {
        get {
            return point
        }
        //修改 point的值必须写 set 方法，结构体是值类型
        set {
            point = newValue
        }
    }
}

var pm = PointManger()
pm[0].x = 11
pm[0].y = 22
print(pm.point)

//类作为返回值
class Point1 {
    var x = 10, y = 10
}

class PointManger1 {
    var point = Point1()
    subscript (index: Int) -> Point1 {
        get {
            return point
        }
        //修改 point的值不用写 set 方法，类是引用类型
    }
}

var pm1 = PointManger1()
pm1[0].x = 11
pm1[0].y = 22
print(pm1.point)
