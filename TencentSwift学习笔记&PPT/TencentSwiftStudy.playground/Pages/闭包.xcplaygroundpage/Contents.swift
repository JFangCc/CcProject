//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//闭包表达式
//本质是函数，类似OC的Block
//{
//    () -> () in
//}

func dsds(ss: Int) -> Int {
    return 5
}

var sasas = {
    (v1: Int, v2: String) -> String in "111"
}
print(sasas(3, "4"))


func test(fn: (Int, Int) -> Int) {
   print("\(fn(3,4))")
}

//闭包表达式不同写法
test(fn: {(v1: Int, v2: Int) -> Int in
    return v1 + v2
})

test(fn: {v1, v2 in
    return v1 + v2
})

test(fn: {$0 + $1})

test(fn: +)

//尾随闭包 写法
// 最后一个参数为闭包 ，写在函数调用，参数括号的后面，尾随闭包
test { (v1, v2) -> Int in
    return v1 + v2
}

test { v1, v2 in
    return v1 + v2
}

//闭包
//一个函数和它所捕获的变量\常量环境组合起来，称为闭包
//一般定义在函数内部的函数
//一般它捕获的是外层函数的局部变量\常量
//可以把闭包想象是一个类的实例对象，内存在堆空间，捕获变量\常量就是对象的成员（存储属性），组成闭包的函数就是类内部定义的方法
typealias Fn = (Int) -> (Int)
func getFn() -> Fn {
    //局部变量
    //发现sum访问了外层函数的变量，捕获变量，就会申请一段堆空间，num内存不会变，后面访问是同一个num
    var num = 0
    func sum(_ i: Int) -> Int {
        num += i
        return num
    }
    return sum
}// 返回的 sum 和 num 形成了闭包

//分配了一份堆空间 num = 0
var fn1 = getFn()
print(fn1(1))
print(fn1(2))
//1、3

//又分配了一份堆空间 num = 0
var fn2 = getFn()
print(fn2(3))
print(fn2(4))
//3、7


//可以把闭包想象是一个类的实例对象 Closure()，内存在堆空间，捕获变量\常量就是对象的成员（存储属性），组成闭包的函数就是类内部定义的方法
class Closure {
    var num = 0
    func sum(_ i: Int) -> Int {
        num += i
        return num
    }
}

var cs1 = Closure()
print(cs1.sum(1))
print(cs1.sum(2))
//1、3

var cs2 = Closure()
print(cs2.sum(3))
print(cs2.sum(4))
//3、7

//注意
//如果返回值是函数类型，那么参数的修饰要保持一致


//自动闭包
func getFirstPositive(_ v1: Int, _ v2: () -> Int) -> Int {
    return v1 > 0 ? v1 : v2()
}
getFirstPositive(4,{10})
getFirstPositive(4){10}

//自动闭包 关键字autoclosure
//只支持 () -> T 格式的参数，无参的
//使用自动闭包 是延迟执行的，有可能会不执行，如以下，v2不会调用
func getFirstPositive1(_ v1: Int, _ v2: @autoclosure () -> Int) -> Int {
    return v1 > 0 ? v1 : v2()
}
//将20 自动封装为闭包 {20}
getFirstPositive1(3, 20)
// 空合运算符 ?? 利用了 autoclosure 技术
// a ?? b ，??函数接收一个闭包 b，将b自动打为闭包
