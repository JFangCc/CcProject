import UIKit

var str = "Hello, playground"

//自动引用计数
///Swift 使用自动引用计数（ARC）机制来跟踪和管理你的应用程序的内存
///ARC 会在类的实例不再被使用时，自动释放其占用的内存

//attention: 引用计数仅仅应用于类的实例。结构体和枚举类型是值类型，不是引用类型，也不是通过引用的方式存储和传递。

//自动引用计数的工作机制
///每当你创建一个新的类实例时，ARC 会分配一块内存来储存该实例的信息。内存中会包含实例的类型信息，以及这个实例所关联的任何存储属性的值。

//自动引用计数实践
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

//reference1 到 Person 类的新实例之间建立了一个强引用
reference1 = Person(name: "fangjing")
// 打印“fangjing Appleseed is being initialized”

//该实例又会多出两个强引用
reference2 = reference1
reference3 = reference1

//断开强引用
reference1 = nil
reference2 = nil

//强引用被全部断开，ARC 会销毁 Person实例
reference3 = nil
// 打印“fangjing Appleseed is being deinitialized”

//类实例之间的循环强引用
///如果两个类实例互相持有对方的强引用，因而每个实例都让对方一直存在，就是这种情况。这就是所谓的循环强引用。
class Person1 {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person1?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

var fangjing: Person1?
var unit4A :Apartment?

fangjing = Person1(name: "fangjing")
unit4A = Apartment(unit: "4A")

//两个实例现在相互强引用
fangjing!.apartment = unit4A
unit4A!.tenant = fangjing

fangjing = nil
unit4A = nil

//解决实例之间的循环强引用之一
//fangjing!.apartment = nil
//unit4A!.tenant = nil

//Swift 提供了两种办法用来解决你在使用类的属性时所遇到的循环强引用问题：
//弱引用（weak reference）和无主引用（unowned reference）
class Person2 {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment2?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment2 {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person2?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

var john2: Person2?
var unit4A2: Apartment2?

john2 = Person2(name: "John Appleseed")
unit4A2 = Apartment2(unit: "4A")

john2!.apartment = unit4A2
unit4A2!.tenant = john2

john2 = nil
unit4A2 = nil

//无主引用
//关键字 unowned 表示这是一个无主引用。
//1、和弱引用类似，无主引用不会牢牢保持住引用的实例
//2、不同的是，无主引用在其他实例有相同或者更长的生命周期时使用
//3、 ARC 无法在实例被销毁后将无主引用设为 nil，因为非可选类型的变量不允许被赋值为 nil
/*
 1、使用无主引用，你必须确保引用始终指向一个未销毁的实例。
 2、如果你试图在实例被销毁后，访问该实例的无主引用，会触发运行时错误。
 */
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    //CreditCard 类的 number 属性被定义为 UInt64 类型而不是 Int 类型，以确保 number 属性的存储量在 32 位和 64 位系统上都能足够容纳 16 位的卡号。

    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}

var fang: Customer?
fang = Customer(name: "jing")
fang?.card = CreditCard(number: 1234_5678_9012_3456, customer: fang!)

//由于再也没有指向 Customer 实例的强引用，该实例被销毁了。其后，再也没有指向 CreditCard 实例的强引用，该实例也随之被销毁了：
fang = nil

//无主引用和隐式解包可选值属性
class Country {
    let name: String
    //声明为隐式解包可选值类型的属性，不需要解包就能访问它
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}
//上述的意义在于你可以通过一条语句同时创建 Country 和 City 的实例，而不产生循环强引用，并且 capitalCity 的属性能被直接访问，而不需要通过感叹号来解包它的可选值：

let country = Country(name: "China", capitalName: "BeiJing")
print(country.capitalCity.name, country.capitalCity.country.name)

//闭包的循环强引用
class HTMLElement {

    let name: String
    let text: String?

    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}

let heading = HTMLElement(name: "h1")
let defaultText = "some text"
heading.asHTML = {
    return "fjfjfjfjjfj"
}
print(heading.asHTML())

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())

paragraph = nil

//解决闭包的循环强引用

//定义捕获列表
/*
lazy var someClosure = {
    [unowned self, weak delegate = self.delegate]
    (index: Int, stringToProcess: String) -> String in
    // 这里是闭包的函数体
}
 */

//如果闭包没有指明参数列表或者返回类型，它们会通过上下文推断，那么可以把捕获列表和关键字 in 放在闭包最开始的地方：
/*
 lazy var someClosure = {
 [unowned self, weak delegate = self.delegate] in
 // 这里是闭包的函数体
 }
 */

//弱引用和无主引用
/*
 1、弱引用总是可选类型，并且当引用的实例被销毁后，弱引用的值会自动置为 nil
 2、如果被捕获的引用绝对不会变为 nil，应该用无主引用，而不是弱引用
 */

class HTMLElement1 {

    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        //捕获列表 [unowned self] 表示“将 self 捕获为无主引用而不是强引用”
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        }else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}

var paragraph1: HTMLElement1? = HTMLElement1(name: "p", text: "hello, world")
print(paragraph1!.asHTML())

paragraph1 = nil
