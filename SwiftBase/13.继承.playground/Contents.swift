import UIKit

var str = "Hello, playground"

//继承
///一个类可以继承另一个类的方法，属性和其它特性。当一个类继承其它类时，继承类叫子类，被继承类叫超类（或父类）。在 Swift 中，继承是区分「类」与其它类型的一个基本特征。

///一个类可以继承另一个类的方法，属性和其它特性。

//定义一个基类，不继承于其它类的类，称之为基类。
///Swift 中的类并不是从一个通用的基类继承而来的。如果你不为自己定义的类指定一个超类的话，这个类就会自动成为基类。
class Vehicle {
    var curSpeed = 0.0
    //计算型属性
    var description: String {
        get {
            return "traveling at \(curSpeed) miles per hour"
        }
    }
    func makeNoise() {
        // 什么也不做
    }
}

//可以用初始化语法创建一个 Vehicle 的新实例，即类名后面跟一个空括号：
let someVehicle = Vehicle()
print(someVehicle.curSpeed,someVehicle.description)

//子类生成
///为了指明某个类的超类，将超类名写在子类名的后面，用冒号分隔：
class Bicycle: Vehicle {
    var hasdsd = false
}
let bicycle = Bicycle()
bicycle.hasdsd = true
print(bicycle.hasdsd)
bicycle.curSpeed = 9.9
print(bicycle.description)

class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}
let tandem = Tandem()
tandem.hasdsd = true
tandem.currentNumberOfPassengers = 2
tandem.curSpeed = 22.0
print("Tandem: \(tandem.description)")
// 打印：“Tandem: traveling at 22.0 miles per hour”

//重写
///子类可以为继承来的实例方法，类方法，实例属性，类属性，或下标提供自己定制的实现。我们把这种行为叫重写。
///如果要重写某个特性，你需要在重写定义的前面加上 override 关键字

//访问超类的方法，属性及下标
///在合适的地方，你可以通过使用 super 前缀来访问超类版本的方法，属性或下标：

//重写方法 在子类中，你可以重写继承来的实例方法或类方法，提供一个定制或替代的方法实现。
class Train: Vehicle {
    override func makeNoise() {
        print("choo choo")
    }
}

let train = Train()
train.makeNoise()

//重写属性
///你可以重写继承来的实例属性或类型属性，提供自己定制的 getter 和 setter，或添加属性观察器，使重写的属性可以观察到底层的属性值什么时候发生改变。

//重写属性的 Getters 和 Setters
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + "in gear \(gear)"
    }
}
let car = Car()
car.curSpeed = 44
car.gear = 5
print(car.description)


//重写属性观察器
class AutomaticCar: Car {
    override var curSpeed: Double {
        didSet {
            gear = Int(curSpeed / 10.0) + 1
        }
    }
}

let automatic = AutomaticCar()
automatic.curSpeed = 35.0
print("AutomaticCar: \(automatic.description)")

//防止重写
//final var、final func、final class func 以及 final subscript
//在声明关键字前加上 final 修饰符来防止 方法，属性或下标被子类重写
final class sss: Car {
    var sssss = 0
}

//报错 禁止重写/继承 超类
//class ddd: sss {
//
//}

class fff: Car {
    final var sssss: Int {
        return 0
    }
}

//报错 禁止重写 超类属性
//class ggg :fff {
//    var dsd = 0
//    override var sssss : Int {
//        return 5
//    }
//}

class hhh: Car {
    var sssss: Int
    init(ss: Int) {
        sssss = ss
    }
}

class bbb: hhh {
    var rrr = 9
    override init(ss: Int) {
        super.init(ss: ss)
    }
}
let dsdsd = bbb(ss: 66)
print(dsdsd.sssss,dsdsd.rrr)

class gdgdg:bbb {
    override var rrr: Int {
        //设置 只读属性 观察器
        willSet {
            
        }
    }
}

