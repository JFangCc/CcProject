import UIKit

var str = "Hello, playground"

//实例方法（Instance Methods）
///类、结构体、枚举都可以定义实例方法
///实例方法是属于某个特定类、结构体或者枚举类型实例的方法

class Counter {
    var count = 0
    func increment() {
        count += 1
        //你可以在一个实例的实例方法中使用 self 属性来引用当前实例。
//        self.count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count += 0
    }
}

let counter = Counter()
counter.increment()
counter.increment(by: 5)
counter.reset()

//self 属性
///使用 self 这条规则的主要场景是实例方法的某个参数名称与实例的某个属性名称相同的时候。在这种情况下，参数名称享有优先权
///这时你可以使用 self 属性来区分参数名称和属性名称。

struct Point {
    var x = 0.0, y = 0
    func isToTheRightOf(x: Double) -> Bool {
        //如果不使用 self 前缀，Swift会认为 x 的两个用法都引用了名为 x 的方法参数。
        return self.x > x
    }
}

let somepoint = Point(x: 5.5, y: 9)
if somepoint.isToTheRightOf(x: 4) {
    print("yes")
}

//在实例方法中修改值类型
///结构体和枚举是值类型。默认情况下，值类型的属性不能在它的实例方法中被修改。
struct Point1 {
    var x = 0.0, y = 0.0
    //方法定义时加上了 mutating 关键字，从而允许修改属性
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somepoint1 = Point1(x: 1, y: 2)
somepoint1.moveBy(x: 2, y: 3)
print("The point is now at (\(somepoint1.x), \(somepoint1.y))")
//注意，不能在结构体类型的常量（a constant of structure type）上调用可变方法，因为其属性不能被改变，即使属性是变量属性，详情参见 常量结构体的存储属性：
/*
 let fixedPoint = Point(x: 3.0, y: 3.0)
 fixedPoint.moveBy(x: 2.0, y: 3.0)
 // 这里将会报告一个错误
 */

//在可变方法中给 self 赋值
///可变方法能够赋给隐含属性 self 一个全新的实例。上面 Point 的例子可以用下面的方式改写：
struct Point2 {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point2(x: x + deltaX, y: y + deltaY)
    }
}
var sds = Point2(x: 2, y: 3)
sds.moveBy(x: 2, y: 3)
print(sds.x, sds.y)

//枚举的可变方法可以把 self 设置为同一枚举类型中不同的成员：
enum Trsdsds {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

var dsds = Trsdsds.high
dsds.next()
print(dsds)
dsds.next()
print(dsds)

//类型方法 - 类方法
///实例方法是被某个类型的实例调用的方法。你也可以定义在类型本身上调用的方法，这种方法就叫做类型方法
class SomeClass {
    class func someTypeMethod() {
        print("ewewewewe")
    }
}
SomeClass.someTypeMethod()
//在类型方法的方法体（body）中，self 属性指向这个类型本身，而不是类型的某个实例

struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1

    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }

    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }

    @discardableResult //标注在方法前面，可以忽略使用方法返回值，消除警告
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Argyrios")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
// 打印“highest unlocked level is now 2”

player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}
// 打印“level 6 has not yet been unlocked”
