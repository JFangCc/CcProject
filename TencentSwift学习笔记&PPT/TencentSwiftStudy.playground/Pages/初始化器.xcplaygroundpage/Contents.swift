//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//类、结构体、枚举 多可以定义初始化器
class Size {
    var age: Int
    init(age: Int) {
        self.age = age
    }
}

struct Point {
    var x = 0
    var y: Int
}

//指定初始化器
//指定初始化器必须从它的直系父类调用指定初始化器，且放在最后调用
//init(){
//
//}
//便捷初始化器
//便捷初始化器 比较安全，必须调用自己的指定初始化器，且放在前面调用

//convenience init(){
//
//}
//便捷初始化器 比较安全，必须调用自己的指定初始化器，且放在前面调用
class Size1 {
    var width: Int = 0
    var height: Int = 0
    //便捷初始化器 必须从类里调用一个指定初始化器
    convenience init(width: Int, height: Int){
        //指定初始化器 或 默认初始化器
        self.init()
        self.width = width
        self.height = height
    }
}
var s = Size1()

//指定初始化器必须从它的直系父类调用指定初始化器，且放在最后调用
class Person {
    var age: Int
    init(age: Int) {
        self.age = age
    }
    convenience init() {
        self.init(age: 0)
    }
}

class Student: Person {
    var score: Int
    init(age: Int, score: Int) {
        self.score = score
        //直系父类调用指定初始化器，且放在最后调用
        super.init(age: age)
    }
}


//重写初始化器
class Person1 {
    var age: Int = 0
    init(age: Int) {
        self.age = age
    }
}

class Student1: Person1 {
    var score: Int = 0
    override init(age: Int) {
        super.init(age: age)
        
    }
}

//子类无法重写父类的便捷初始化器，即使方法名字参数 一模一样，所以不需要加 override

//自动继承
//如果 Stu没有指定初始化器 会自动继承 Student1的指定初始化器
class Stu: Student1 {
    convenience init (no: Int) {
        self.init(age: 6)
    }
}

var stu = Stu(no: 5)

//用required 修饰指定初始化器，表明其所有子类都必须实现该初始化器（继承、重写）
//如果子类重写了 required 初始化器，必须加上required，不用加 override
class Person2 {
    required init(){
    }
    init(age: Int) {
    }
}

class Stu2: Person2 {
    required init() {
        super.init()
    }
    init(age: Int, agse: Int) {
        super.init()
    }
}

var sss = Stu2()


//可失败初始化器
class Person3 {
    var age: String
    init?(age: String) {
        if age.isEmpty {
            return nil
        }
        self.age = age
    }
}

var p3 = Person3(age: "")


//反初始化器 deinit 类似 OC 的dealloc
class Person4 {
    deinit {
        print("0000")
    }
    func www() {
        print("1111")
    }
}
class rrrr {
    func www() {
        let p4 = Person4()
        p4.www()
    }
    deinit {
        print("00001")
    }
}

func method() {
    let rr = rrrr()
    rr.www()
}
method()


