import UIKit

var str = "Hello, playground"

//存储属性
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

// 该区间表示整数 0，1，2
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
// 该区间表示整数 6，7，8
rangeOfThreeItems.firstValue = 6

//常量结构体实例的存储属性
///如果创建了一个结构体实例并将其赋值给一个常量，则无法修改该实例的任何属性，即使被声明为可变属性也不行:
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
// 该区间表示整数 0，1，2，3
// rangeOfFourItems.firstValue = 6
// 尽管 firstValue 是个可变属性，但这里还是会报错

//延时加载存储属性
///延时加载存储属性是指当第一次被调用的时候才会计算其初始值的属性。在属性声明前使用 lazy 来标示一个延时加载存储属性。
class DataImporter {
    /*
    DataImporter 是一个负责将外部文件中的数据导入的类。
    这个类的初始化会消耗不少时间。
    */
    var fileName = "data.txt"
    // 这里会提供数据导入功能
}

class DataManger {
    lazy var importer = DataImporter()
    var data = [String]()
    // 这里会提供数据管理功能
}

let manger = DataManger()
manger.data.insert("some data", at: 0)
manger.data.append("some more data")
print(manger.data)
//由于使用了 lazy，DataImporter 的实例 importer 属性只有在第一次被访问的时候才被创建。比如访问它的属性 fileName 时：
print(manger.importer.fileName)
//如果一个被标记为 lazy 的属性在没有初始化时就同时被多个线程访问，则无法保证该属性只会被初始化一次。

//存储属性和实例变量
///如果你有过 Objective-C 经验，应该知道 Objective-C 为类实例存储值和引用提供两种方法。除了属性之外，还可以使用实例变量作为一个备份存储将变量值赋值给属性。

//计算属性
///除存储属性外，类、结构体和枚举可以定义计算属性。计算属性不直接存储值，而是提供一个 getter 和一个可选的 setter，来间接获取和设置其他属性或变量的值。
struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}

var square = Rect(origin: Point(x: 0, y: 0), size: Size(width: 10, height: 10))
let initialSquareCenter = square.origin
square.center = Point(x: 15, y: 15)
print(initialSquareCenter,square.origin,square.size,square.center)

//简化 Setter 声明
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

//简化 Getter 声明
///在 getter 中忽略 return 与在函数中忽略 return 的规则相同，请参考 隐式返回的函数。
struct CompactRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            Point(x: origin.x + (size.width / 2),
                  y: origin.y + (size.height / 2))
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

//只读计算属性
///只有 getter 没有 setter 的计算属性叫只读计算属性。只读计算属性总是返回一个值，可以通过点运算符访问，但不能设置新的值。
///必须使用 var 关键字定义计算属性，包括只读计算属性，因为它们的值不是固定的。let 关键字只用来声明常量属性，表示初始化后再也无法修改的值。
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}

let ddd = Cuboid(width: 2, height: 3, depth: 4)
print(ddd.volume)

//属性观察器
///属性观察器监控和响应属性值的变化，每次属性被设置值的时候都会调用属性观察器，即使新值和当前值相同的时候也不例外。
/*
 你可以在以下位置添加属性观察器：
 自定义的存储属性
 继承的存储属性
 继承的计算属性
 */

//可以为属性添加其中一个或两个观察器：
/*
 willSet 在新的值被设置之前调用
 didSet 在新的值被设置之后调用
 */

class StepCounter {
    var totalSteps:Int = 0 {
        willSet(newTotalSteps) {
            print("总步数: \(newTotalSteps)")
        }
        didSet {
            if(totalSteps > oldValue) {
                print("增加了: \(totalSteps - oldValue) 步")
            }
        }
    }
}

let set = StepCounter()
set.totalSteps = 300
set.totalSteps = 400
set.totalSteps = 500

//全局变量和局部变量
/// 全局的常量或变量都是延迟计算的，跟 延时加载存储属性 相似，不同的地方在于，全局的常量或变量不需要标记 lazy 修饰符。

//类型属性语法
///使用关键字 static 来定义类型属性
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    //存储类型属性
    static var storedTypeProperty = "Some value."
    //计算类型属性
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    //可以改用关键字 class 来支持子类对父类的实现进行重写
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

//获取和设置类型属性的值
print(SomeStructure.storedTypeProperty)
// 打印“Some value.”
SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)
// 打印“Another value.”
print(SomeEnumeration.computedTypeProperty)
// 打印“6”
print(SomeClass.computedTypeProperty)
// 打印“27”
