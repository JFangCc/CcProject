//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//协议定义属性 必须用var
protocol Drawable {
    func drwa()
    var x: Int {get set} //可读可写
    var y: Int {get} //只读
    subscript(index: Int) -> Int {get set}
}

class Person: Drawable {
    var x: Int = 0
    var y: Int = 0
    
    func drwa() {
        print("")
    }
    subscript(index: Int) -> Int {
        get{
            index
        }
        set {
            
        }
    }
}

class Person1: Drawable {
    var x: Int {
        get { 0 }
        set {
            
        }
    }
    var y: Int {
        get { 0 }
        set {
            
        }
    }
    func drwa() {
        print("")
    }
    subscript(index: Int) -> Int {
        get{
            index
        }
        set {
            
        }
    }
}


//static、 class
//为保证通用 用 static 定义类型方法、类型属性、类型下标

protocol Drawable1 {
    static func drwa()
}

class Person2: Drawable1 {
    static func drwa() {
        print("")
    }
}

class Person3: Drawable1 {
    class func drwa() {
        print("")
    }
}


//mutating
//协议中的实例方法 标记为mutating，值类型对象（结构体、枚举）才能修改自身内存
protocol Drawable3 {
    mutating func drwa()
}

struct Person4: Drawable3 {
    var num = 0
    mutating func drwa() {
        num = 8
        print("")
    }
}

//init
//非 final 类实现时必须加上 required
protocol Drawable4 {
    init(x: Int, y: Int)
}

class Person5: Drawable4 {
    required init(x: Int, y: Int) {
        
    }
}

final class Person6: Drawable4 {
    init(x: Int, y: Int) {
        
    }
}

//协议组合
protocol Livable {
    
}

protocol Livable1 {
    
}

protocol Livable2 {
    
}

func test(v1: Livable) {
    
}

func test1(v1: Livable & Livable1) {
    
}

func test2(v1: Livable & Livable1 & Livable2) {
    
}

typealias LA = Livable & Livable1 & Livable2
func test(v1: LA) {
    
}

//Any、可以代表任意类型
//AnyObject、表示任意 类类型的对象
var data: [Any] = []
data = Array<Any>()
data.append(1)
data.append({4})
data.append("www")


// is 用来判断是否为某种类型，as 用来做强制类型转换
print(data is [Any])
print(data is Int)
print(data is Any)
print(data is String)

print((data as? [Any])?[0])

data.append(Int("222"))
//消除警告
data.append(Int("222") as Any)

//X.self、X.Type、AnyClass
class Person7 {
    required init() {
    }
}
print(Person7.self)// Person7 类的元类型

//AnyObject 和 AnyObject.Type 是两回事
var p7: AnyObject = Person7()
var anyType: AnyObject.Type = Person7.self

// 元类型函数
var pType = type(of: p7)
print(pType) // Person7 类的元类型

var type1 = Person7.self
//type1.init() 等价于 Person7() 的实例
print(type1.init() is Person7) //true

//Self
protocol Runnable {
    func test() -> Self
}

class Person8: Runnable {
    required init() {
    }
    func test() -> Self {
        type(of: self).init()
    }
}
var p8 = Person8()
print(p8.test())

class Stu: Person8 {
}

var sss = Stu()
print(sss.test())


var see = ["2"]
see.forEach{ str in
    print("1111")
}

