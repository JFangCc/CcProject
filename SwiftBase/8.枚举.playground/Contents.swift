import UIKit

var str = "Hello, playground"

//枚举为一组相关的值定义了一个共同的类型，使你可以在你的代码中以类型安全的方式来使用这些值。
//在 Swift 中，枚举类型是一等（first-class）类型
//枚举语法
enum SomeEnumeration {
    //枚举定义放在这里
}

enum Sex {
    case man
    case women
}

enum Planet {
    case www,ewe,erer,qwwq,wqeqwe,ewrwe,dasda,asdasd
}

var sex = Sex.man
print(sex)
///当 directionToHead 的类型已知时，再次为其赋值可以省略枚举类型名。在使用具有显式类型的枚举值时，这种写法让代码具有更好的可读性。

sex = .women
print(sex)

//使用 Switch 语句匹配枚举值
switch sex {
case .man:
    print(sex)
case .women:
    print(sex)
}

let somePlanet = Planet.erer
switch somePlanet {
case .erer:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}

//枚举成员的遍历
///在一些情况下，你会需要得到一个包含枚举所有成员的集合。可以通过如下代码实现：
enum Beeew:CaseIterable {
    case w
    case f
    case s
    case r
}
print(Beeew.allCases)
for bev in Beeew.allCases {
    print(bev)
}

//关联值
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
var pro = Barcode.qrCode("fangjing")
print(productBarcode)

switch productBarcode {
case .upc(let numberSystem,let manufacturer,let product,let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}

///如果一个枚举成员的所有关联值都被提取为常量，或者都被提取为变量，为了简洁，你可以只在成员名称前标注一个 let 或者 var：

switch pro {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}

//原始值
//原始值可以是字符串、字符，或者任意整型值或浮点型值。每个原始值在枚举声明中必须是唯一的。

enum Beeeq: Int {
    case w = 2
    case f = 3
    case s = 4
    case r = 5
}
print(Beeeq.f.rawValue)
//原始值的隐式赋值
//例如，当使用整数作为原始值时，隐式赋值的值依次递增 1。如果第一个枚举成员没有设置原始值，其原始值将为 0。
enum Planetw: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

//使用原始值初始化枚举实例
if let possiblePlanet = Planetw(rawValue: 7) {
    print(possiblePlanet.rawValue)
}

let none = 7
switch none {
case Planetw.uranus.rawValue:
    print(Planetw.uranus)
default:
    print("no")
}

let positionToFind = 11
if let somePlanet = Planetw(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}

//递归枚举
///递归枚举是一种枚举类型，它有一个或多个枚举成员使用该枚举类型的实例作为关联值。使用递归枚举时，编译器会插入一个间接层。你可以在枚举成员前加上 indirect 来表示该成员可递归。
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}
//你也可以在枚举类型开头加上 indirect 关键字来表明它的所有成员都是可递归的：
indirect enum ArithmeticExpression1 {
    case number(Int)
    case addition(ArithmeticExpression1, ArithmeticExpression1)
    case multiplication(ArithmeticExpression1, ArithmeticExpression1)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
// (5+4)*2
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
let product1 = ArithmeticExpression.multiplication(sum, four)
// (5+4)*(5+4)
let product2 = ArithmeticExpression.multiplication(product, product)

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case .number(let a):
        return a
    case .addition(let a, let b):
        return evaluate(a) + evaluate(b)
    case .multiplication(let a, let b):
        return evaluate(a) * evaluate(b)
    }
}

print(evaluate(product2))
