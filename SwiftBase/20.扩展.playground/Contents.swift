import UIKit

var str = "Hello, playground"

//扩展可以给一个现有的类，结构体，枚举，还有协议添加新的功能

/*
 添加计算型实例属性和计算型类属性
 定义实例方法和类方法
 提供新的构造器
 定义下标
 定义和使用新的嵌套类型
 使已经存在的类型遵循（conform）一个协议
 */

//扩展的语法
/// 使用 extension 关键字声明扩展
class SomeType {
    
}

extension SomeType {
    // 在这里给 SomeType 添加新的功能
}

//扩展可以扩充一个现有的类型，给它添加一个或多个协议。协议名称的写法和类或者结构体一样：
/*
 extension SomeType: SomeProtocol, AnotherProtocol {
   // 协议所需要的实现写在这里
 }
 */

//计算型属性
/*
 1、扩展可以给现有类型添加计算型实例属性和计算型类属性
 2、扩展不能添加存储属性，或向现有的属性添加属性观察者。

 */
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
    var fj: Double { return self * 2}
}

let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")

let fj = 4.fj
print(fj)

let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")

//构造器
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}
let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
   size: Size(width: 5.0, height: 5.0))
//你可以通过扩展 Rect 结构体来提供一个允许指定 point 和 size 的构造器：
extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))
// centerRect 的 origin 是 (2.5, 2.5) 并且它的 size 是 (3.0, 3.0)
//如果你通过扩展提供一个新的构造器，你有责任确保每个通过该构造器创建的实例都是初始化完整的。

//方法
///扩展可以给现有类型添加新的实例方法和类方法。在下面的例子中，给 Int 类型添加了一个新的实例方法叫做 repetitions：
extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

let fjfjfj = 6
fjfjfj.repetitions {
    print("666")
}

//可变实例方法
/*
 1、通过扩展添加的实例方法同样也可以修改（或 mutating（改变））实例本身。
 2、结构体和枚举的方法，若是可以修改 self 或者它自己的属性，则必须将这个实例方法标记为 mutating
 */
extension Int {
    mutating func square() {
        self = self * self
    }
}
var someInt = 8
someInt.square()
print(someInt)

//下标
///扩展可以给现有的类型添加新的下标
extension Int {
    subscript(index: Int) -> Int {
        var num = 1
        for _ in 0..<index {
            num *= 10
        }
        return (self / num) % 10
    }
}

let ee = 236236237[4]
print(ee)
//下标超限，返0
let zero = 746381295[9]
// 返回 0，就好像你进行了这个请求：
0746381295[9]
print(zero)

//嵌套类型
///扩展可以给现有的类，结构体，还有枚举添加新的嵌套类型：
extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

let ttt = 9.kind
print(ttt)

func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}
printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
// 打印“+ + - 0 - 0 + ”
