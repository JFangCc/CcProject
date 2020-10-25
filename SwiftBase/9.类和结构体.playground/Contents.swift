import UIKit

var str = "Hello, playground"

//结构体和类作为一种通用而又灵活的结构，成为了人们构建代码的基础。你可以使用定义常量、变量和函数的语法，为你的结构体和类定义属性、添加方法。
//Swift 中结构体和类有很多共同点。两者都可以：
/*
 定义属性用于存储值
 定义方法用于提供功能
 定义下标操作用于通过下标语法访问它们的值
 定义构造器用于设置初始值
 通过扩展以增加默认实现之外的功能
 遵循协议以提供某种标准功能
 */
//类型定义的语法
///结构体和类有着相似的定义方式。你通过 struct 关键字引入结构体，通过 class 关键字引入类，并将它们的具体定义放在一对大括号中：
struct SomeStructure {
    //在这里定义结构体
}
class SomeClaee {
    //在这里定义类
}
//以下是定义结构体和定义类的示例：
struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

//结构体和类的实例
///创建结构体和类实例的语法非常相似：
let someResolution = Resolution()
let someVideoMode = VideoMode()

//属性访问
///你可以通过使用点语法访问实例的属性。其语法规则是，实例名后面紧跟属性名，两者以点号（.）分隔，不带空格：
print("the width of someresolution is \(someResolution.width)")
print("the width of someresolution is \(someVideoMode.resolution.height) is \(someVideoMode.frameRate)")

someVideoMode.resolution.width = 8
print("the width of someresolution is \(someVideoMode.resolution.width)")

//结构体类型的成员逐一构造器
let vga = Resolution(width: 640, height: 480)
///与结构体不同，类实例没有默认的成员逐一构造器

//结构体和枚举是值类型
///值类型是这样一种类型，当它被赋值给一个变量、常量或者被传递给一个函数的时候，其值会被拷贝。
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd //尽管 hd 和 cinema 有着相同的宽（width）和高（height），但是在幕后它们是两个完全不同的实例。
cinema.width = 2048
print(cinema.width, cinema.height)

enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
}
var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection.turnNorth()

print("The current direction is \(currentDirection)")
print("The remembered direction is \(rememberedDirection)")

//类是引用类型
///与值类型不同，引用类型在被赋予到一个变量、常量或者被传递到一个函数时，其值不会被拷贝。因此，使用的是已存在实例的引用，而不是其拷贝。
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.resolution.width = 3000
print(tenEighty.resolution.width)

//恒等运算符
///因为类是引用类型，所以多个常量和变量可能在幕后同时引用同一个类实例。（对于结构体和枚举来说，这并不成立。因为它们作为值类型，在被赋予到常量、变量或者传递到函数时，其值总是会被拷贝。）

//判定两个常量或者变量是否引用同一个类实例有时很有用。为了达到这个目的，Swift 提供了两个恒等运算符：
/*
 相同（===）
 不相同（!==）
 */
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}
