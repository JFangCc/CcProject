//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//存储属性
//结构体和类才能定义存储属性，枚举不行

struct Point {
    //存储在实例的内存里面
    var x: Int
    var y: Int
}

var p = Point(x: 20, y: 20)
print(MemoryLayout.stride(ofValue: p))

//计算型属性
//本质是方法（函数）
//不占用实例的内存（方法(函数)是不占用实力对象内存的）
//结构体和类、枚举都可以定义计算型属性，因其本质是方法，枚举可以定义方法

struct Circle {
    //存储属性
    var radius: Double
    //计算属性
    var diameter: Double {
        set {
            radius = newValue / 2
        }
        get {
            radius * 2
        }
    }
}

var c = Circle(radius: 10)
c.diameter = 11
print(c.radius)

//关于存储属性 在创建类、结构体的实例时，必须为所有的存储属性设置一个合适的初始值
//计算属性只能用 var 修饰
//计算属性 有set方法必须 有get方法
struct Poooin {
    var x: Int
    var y: Int
}
var pp = Poooin(x: 4, y: 3)

struct Poooin1 {
    var x: Int = 2
    var y: Int = 8
}
var p1 = Poooin1()

//枚举的原始值 实现原理就是计算型属性 ⬇️
enum Yuan: Int {
    case a = 1, b, c, d
    var rawValue: Int {
        switch self {
        case .a:
            return 11
            case .b:
            return 22
            case .c:
            return 33
            case .d:
            return 44
        }
    }
}
var y = Yuan.b
print(y.rawValue)


//延迟存储属性 lazy 关键字，第一次用到属性的时候才会初始化
//初始化比较耗时的操作一般用lazy，比如属性有图片加载的实现
//lazy 属性必须是 var 类型
//如果多线程同时第一次访问lazy属性，不是线程安全的，无法保证 lazy修饰的属性只被初始化一次
class Car {
    init() {
        print("car init")
    }
    func run() {
        print("car running")
    }
}

class Person {
    lazy var car = Car()
    init() {
        print("person init")
    }
    func goOut() {
        car.run()
    }
}

let per = Person()
print("-------")
per.goOut()

/*
 person init
 -------
 car init
 car running
 */


//属性观察器
//可以为非 lazy的 var 存储属性设置属性观察器
//初始化器中设置属性值，不会触发观察器
struct Circle1 {
    //存储属性
    var radius: Double {
        willSet {
            print("willSet \(newValue)")
        }
        didSet {
            print("didSet \(oldValue) \(radius)")
        }
    }
    //计算属性
    var diameter: Double {
        set {
            radius = newValue / 2
        }
        get {
            radius * 2
        }
    }
}
var c1 = Circle1(radius: 8)
c1.radius = 4

//输入输出参数 inout 本质是地址引用传递
var num = 10.0
func test(_ num: inout Double) -> Double {
    num += 20
    return num
}
test(&num)
print(num)

test(&c1.radius)

//类型属性 static 或者 class定义 ，类调用，类似于全局变量，不存在于实例内存中
//存储类型属性 默认就是 lazy
//存储类型属性 定义要给初始值
//存储类型属性 只会初始化一次
//枚举可以定义类型属性

struct Shape {
    var width: Int = 1
    static var count: Int = 2
}
var s = Shape()
print(s.width)
//类调用
Shape.count = 3
print(Shape.count)

//类型属性 线程安全的 单例模式
class FileManger {
    public static let shared = FileManger()
    private init () {
    }
    func open() {
    }
    func close() {
    }
}

FileManger.shared.open()
FileManger.shared.close()

class Fang {
    //内存一直停留在程序中，类似全局变量
    static var jing = 1
}
Fang.jing = 8
print(Fang.jing)
