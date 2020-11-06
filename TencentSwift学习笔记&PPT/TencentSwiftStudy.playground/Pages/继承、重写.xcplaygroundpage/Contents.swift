//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//引用类型才支持继承，枚举和结构体（值类型）不支持
//子类可以重写父类的下标、方法、属性，override 关键字

class Animal {
    var age = 0
    func speak() {
        print("speak")
    }
    subscript (index: Int) -> Int {
        return index
    }
}

class Dog: Animal {
    var weight = 0
}

class ErHa: Dog {
    var iq = 0
}

let a = Animal()
a.age = 10
print(MemoryLayout.size(ofValue: a))

let d = Dog()
d.age = 20
d.weight = 10
print(MemoryLayout.size(ofValue: d))

let e = ErHa()
e.age = 20
e.weight = 10
e.iq = 30
print(MemoryLayout.size(ofValue: e))

class Cat: Animal {
    override func speak() {
        print("cat speak")
    }
    override subscript (index: Int) -> Int {
        return super[index] + 1
    }
}

let c = Cat()
c.speak()
print(c[222])

//重写方法
//被 class 修饰的类型方法、下标、允许被子类重写
//被 static 修饰的类型方法、下标、不允许被子类重写

class Animal1 {
    var age = 0
    class func speak() {
        print("speak")
    }
    class subscript (index: Int) -> Int {
        return index
    }
}

class Cat1: Animal1 {
    override static func speak() {
        print("cat speak")
    }
    override static subscript (index: Int) -> Int {
        return super[index] + 1
    }
}

let c1 = Cat1()
Cat1.speak()
print(c[333])

//报错 WhiteCat1 不能重写 Cat1的方法、下标了
//class WhiteCat1: Cat1 {
//    override class func speak() {
//        print("cat speak")
//    }
//    override class subscript (index: Int) -> Int {
//        return super[index] + 1
//    }
//}

//重写实例属性
//子类可以将父类的属性（存储、计算）重写为计算属性
//子类不可以将父类属性重写为存储属性
//只能重写var属性，不能重写let属性
//重写时，属性名，类型要一致
//子类重写后的属性权限不能小于父类属性的权限

class Animal2 {
    var age = 0
}

class Dog2: Animal2 {
    override var age: Int {
        get {
            super.age
        }
        set {
            super.age = newValue
        }
    }
    var weight = 0
}

let d2 = Dog2()
d2.age = 99
print(d2.age)

//重写类型属性
//被 class 修饰的类型属性（计算) 允许被子类重写
//被 static 修饰的类型属性（存储、计算）不允许被子类重写

//属性观察器
//可以在子类中为父类属性（除了只读计算属性、let属性）增加属性观察器
class Dog3: Dog2 {
    override var age: Int {
        willSet {
            
        }
        didSet {
            
        }
    }
}

//被 final 修饰的类 禁止被继承
//被 final 修饰的属性、下标、方法 禁止被重写
final class FFF {
    var e = 0
}
