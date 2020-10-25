import UIKit

var str = "Hello, playground"

//构造过程
//构造器
/*
init() {
    // 在此处执行构造过程
}
 */
struct Fahrenheit {
    var temperature: Double
    //结构体定义了一个不带形参的构造器 init
    init() {
        //华氏温度下水的冰点
        temperature = 36.0
    }
}

var f = Fahrenheit()
print(f.temperature)

//默认属性值
struct Fahrenheit1 {
    var temperature = 32.0
}

//自定义构造过程
///下面例子中定义了一个用来保存摄氏温度的结构体 Celsius。它定义了两个不同的构造器：init(fromFahrenheit:) 和 init(fromKelvin:)，二者分别通过接受不同温标下的温度值来创建新的实例：

struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
print(boilingPointOfWater.temperatureInCelsius)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
print(freezingPointOfWater.temperatureInCelsius)

//形参命名和实参标签
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}

//两种构造器都能通过为每一个构造器形参提供命名值来创建一个新的 Color 实例：
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)
print(magenta.red, halfGray.red)

//不带实参标签的构造器形参
struct Celsius1 {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double){
        temperatureInCelsius = celsius
    }
}
let bodyTemperature = Celsius1(fromKelvin: 56.0)
let bodyTemperature1 = Celsius1(37.0)
print(bodyTemperature.temperatureInCelsius, bodyTemperature1.temperatureInCelsius)

//可选属性类型
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}

let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
// 打印“Do you like cheese?”
print(cheeseQuestion.response)
cheeseQuestion.response = "Yes, I do like cheese."
print(cheeseQuestion.response!)

//构造过程中常量属性的赋值
class SurveyQuestion1 {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion1(text: "How about beets?")
beetsQuestion.ask()
// 打印“How about beets?”
beetsQuestion.response = "I also like beets. (But not with cheese.)"

//默认构造器
///由于 ShoppingListItem 类中的所有属性都有默认值，且它是没有父类的基类，它将自动获得一个将为所有属性设置默认值的并创建实例的默认构造器
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()
print(item.purchased)

//结构体的逐一成员构造器
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)

let zeroByTwo = Size(height: 2.0)
print(zeroByTwo.width, zeroByTwo.height)

let zeroByZero = Size()
print(zeroByZero.width, zeroByZero.height)

//值类型的构造器代理
struct Size1 {
    var width = 5.0, height = 5.0
}
struct Point {
    var x = 0.0, y = 0.0
}
// 三个自定义的构造器：
struct Rect {
    var origin = Point()
    var size = Size1()
    //1.
    init() {
    }
    //2.
    init(origin: Point, size: Size1) {
        self.origin = origin
        self.size = size
    }
    //3.
    init(center: Point, size: Size1) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let rect = Rect()
print(rect.origin,rect.size)
let rect1 = Rect(origin: Point(x: 55, y: 66), size: Size1(width: 77, height: 88))
print(rect1.origin,rect1.size)
let rect2 = Rect(center: Point(x: 99, y: 34), size: Size1(width: 54, height: 23))
print(rect2.origin,rect2.size)

//类的继承和构造过程
///类里面的所有存储型属性——包括所有继承自父类的属性——都必须在构造过程中设置初始值。

//指定构造器和便利构造器的语法
/*
init(parameters) {
    statements
}
 */

//构造器的继承和重写
class Vehicle {
    var num = 0
    var desc: String {
        return "\(num) wheel(s)"
    }
}

let veh = Vehicle()
print(veh.desc)

class Bicycle: Vehicle {
    override init() {
        super.init()
        num = 2
    }
}

let bic = Bicycle()
print(bic.desc)

class Hoverboard: Vehicle {
    var color: String
    init(color: String) {
        self.color = color
        // super.init() 在这里被隐式调用
    }
    override var desc: String {
        return "\(super.desc) in a beautiful \(color)"
    }
}

let hoverboard = Hoverboard(color: "silver")
print("Hoverboard: \(hoverboard.desc)")

//构造器的自动继承
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

//可失败构造器
///为了妥善处理这种构造过程中可能会失败的情况。你可以在一个类，结构体或是枚举类型的定义中，添加一个或多个可失败构造器。其语法为在 init 关键字后面添加问号（init?）。
let wholeNumber: Double = 12345.0
let pi = 3.14159

if let valueMaintained = Int(exactly: wholeNumber) {
    print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
}
// 打印“12345.0 conversion to Int maintains value of 12345”

let valueChanged = Int(exactly: pi)
// valueChanged 是 Int? 类型，不是 Int 类型

if valueChanged == nil {
    print("\(pi) conversion to Int does not maintain value")
}
// 打印“3.14159 conversion to Int does not maintain value”

struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
    }
}

// 空字符串（""）其实是一个有效的，非可选类型的字符串
let someCreature = Animal(species: "")
// someCreature 的类型是 Animal? 而不是 Animal

if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}else {
    print("no")
}

//枚举类型的可失败构造器
enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}

let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}

//必要构造器
class SomeClass {
    //子类必要
    required init() {
        // 构造器的实现代码
    }
}
//required 修饰符，子类在重写父类中必要的指定构造器时，不需要添加 override 修饰符：
class dsdsd: SomeClass {
    required init() {
        
    }
}

//通过闭包或函数设置属性的默认值
class Somedsds {
    let someProperty: String = {
        return "fangjing"
    }()
}

class Somedwsds {
    let someProperty: String
    init() {
        someProperty = "dssd"
    }
}

