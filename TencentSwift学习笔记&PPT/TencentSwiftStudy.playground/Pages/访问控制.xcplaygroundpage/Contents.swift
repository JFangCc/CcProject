//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

// open 权限最大 可以被其他模块访问 类似动态库 允许继承、重写
open class Person {
    
}

// public 可以被其他模块访问，不允许被其他模块继承、重写
public class Person1 {
    
}

// internal 只允许在本项目（模块）中访问，不允许其他模块访问
internal class Person2 {
    
}

// fileprivate 只允许在定义实体的源文件中访问，本类中访问
fileprivate class Person3 {
    
}

// private 只允许在定义实体的封闭声明中访问 类似成员变量
private class Person4 {
   private var num = 0
    
}

//绝大部门实体默认都是 internal 权限
class Person5 {
    var num = 0
}
