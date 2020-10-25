import UIKit

var str = "Hello, playground"

//协议
///某个类型能够满足某个协议的要求，就可以说该类型遵循这个协议。
//协议语法 - 协议的定义方式与类、结构体和枚举的定义非常相似：
protocol SomeProtecol {
    //这里是协议的定义部分
}

//遵循协议用 : 多个协议 , 隔开
/*
 struct SomeStructure: firstProtecol, AnotherProtecol {
     
 }
 */

//若是一个类拥有父类，应该将父类名放在遵循的协议名之前，以逗号分隔：
/*
 class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
 
 }
 */

//属性要求
protocol SomeProtocol {
    var mustBeSettable: Int {
        get set
    }
    var doesNotNeedToBeSettable: Int { get }
}

//static 定义类型属性
protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
    
}
var john = Person(fullName: "fangjing")
//可读属性 也可写
john.fullName = "jing"
print(john.fullName)

class Starship: FullyNamed {
    var prefix: String?
    var name:String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}

var ncc1701 = Starship(name: "fangjing", prefix: "china")
print(ncc1701.fullName)
print(ncc1701.name)
print(ncc1701.prefix!)

//方法要求
///在协议中定义类方法的时候，总是使用 static 关键字作为前缀
protocol SomeProtocol1 {
    //定义类方法
    static func someTypeMethod()
}

protocol RandomNumberGenerator {
    //定义实例方法
    func random() -> Double
}

class dsds:SomeProtocol1 {
    static func someTypeMethod() {
        print("dsdsdsdsd")
    }
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print(generator.random())

//异变方法要求
///mutating 关键字作为改变（或异变）方法的前缀

//toggle() 方法在定义的时候，使用 mutating 关键字标记，这表明当它被调用时，该方法将会改变遵循协议的类型的实例：
protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .on:
            self = .off
        default:
            self = .on
        }
    }
}

var lightSwitch = OnOffSwitch.on
print(lightSwitch)
lightSwitch.toggle()
print(lightSwitch)

//构造器要求
protocol SomeProtocol2 {
    init(param: Int)
}

//协议构造器要求的类实现
class SomeClass: SomeProtocol2 {
    //构造器实现 必须 标上 required 修饰符
    
    //使用 required 修饰符可以确保所有子类也必须提供此构造器实现，从而也能遵循协议。
    required init(param: Int) {
        // 这里是构造器的实现部分
        print("1111111")
    }
}

//如果一个子类重写了父类的指定构造器，并且该构造器满足了某个协议的要求，那么该构造器的实现需要同时标注 required 和 override 修饰符：
protocol SomeProtocol3 {
    init()
}

class SomeSuperClass {
    init() {
        // 这里是构造器的实现部分
    }
}

class SomeSubClass: SomeSuperClass, SomeProtocol3 {
    // 因为遵循协议，需要加上 required
    // 因为继承自父类，需要加上 override
    required override init() {
        // 这里是构造器的实现部分
    }
}

//可失败构造器要求
protocol SomeProtocol4 {
    init?()
}

///遵循协议的类型可以通过可失败构造器（init?）或非可失败构造器（init）来满足协议中定义的可失败构造器要求。协议中定义的非可失败构造器要求可以通过非可失败构造器（init）或隐式解包可失败构造器（init!）来满足。

class fffff: SomeProtocol4 {
    required init?() {
        
    }
    // required init() {}
    // required init!() {}
}

//协议作为类型 「存在类型」
///协议可以像其他普通类型一样使用，使用场景如下：
/*
 # 作为函数、方法或构造器中的参数类型或返回值类型
 # 作为常量、变量或属性的类型
 # 作为数组、字典或其他容器中的元素类型
 */

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides;
        self.generator = generator;
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

let sss = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print(sss.roll())
}

//委托
///委托是一种设计模式，它允许类或结构体将一些需要它们负责的功能委托给其他类型的实例
protocol DiceGame {
    var dice: Dice { get }
    func play()
}
protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()


///自练习委托
protocol DiceGameDelegate1 {
    func gameDidStart(_ game: String)
    func game(_ game: String)
    func gameDidEnd(_ game: String)
}

class eee: DiceGameDelegate1 {
    func gameDidStart(_ game: String) {
        print(game)
    }
    func game(_ game: String) {
        print(game)
    }
    func gameDidEnd(_ game: String) {
        print(game)
    }
}

class aaa {
    var delegate: DiceGameDelegate1?
    func ccc() {
        delegate?.gameDidStart("游戏开始了")
        delegate?.game("游戏进行中")
        delegate?.gameDidEnd("游戏结束了")
    }
}

let ggg = aaa()
let ddd = eee()
ggg.delegate = ddd
ggg.ccc()

//在扩展里添加协议遵循
protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)

extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}
print(game.textualDescription)

//有条件地遵循协议
///下面的扩展让 Array 类型只要在存储遵循 TextRepresentable 协议的元素时就遵循 TextRepresentable 协议。
extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}
let myDice = [d12, d12]
print(myDice.textualDescription)
// 打印 "[A 6-sided dice, A 12-sided dice]"

//在扩展里声明采纳协议
///即使满足了协议的所有要求，类型也不会自动遵循协议，必须显式地遵循协议。
struct Hamster {
    var name: String
       var textualDescription: String {
        return "A hamster named \(name)"
    }
}
//从现在起，Hamster 的实例可以作为 TextRepresentable 类型使用：
extension Hamster: TextRepresentable {}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)

//使用合成实现来采纳协议
struct Vector3D: Equatable {
    var x = 0.0, y = 0.0, z = 0.0
}

let twoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
let anotherTwoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
if twoThreeFour == anotherTwoThreeFour {
    print("These two vectors are also equivalent.")
}

//协议类型的集合
let things: [TextRepresentable] = [game, d12, simonTheHamster]
for thing in things {
    if let sss = thing as? SnakesAndLadders {
        print("111")
    }else if thing is Dice {
        print("222")
    }else if thing is Hamster {
        print("333")
    }
    print(thing.textualDescription)
}

//协议继承
///协议能够继承一个或多个其他协议，可以在继承的协议的基础上增加新的要求。协议的继承语法与类的继承相似，多个被继承的协议间用逗号分隔：
protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // 这里是协议的定义部分
}
protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
    
}

extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}

print(game.prettyTextualDescription)

//协议扩展 和 属性观察器 练习
protocol fangProtocol {
    var fang: String {get set}
}

protocol jingProtocol {
    var jing: String {get}
}

class fangjing: fangProtocol, jingProtocol {
    var name: String = "fang";
    var fang: String {
        get {
            return name
        }
        set {
            name = newValue;
        }
    }
    var jing: String {
        return "jing"
    }
}

class ddfdfdf: fangjing {
    override var fang: String {
        willSet {
            print("11111")
        }
        didSet {
            print("22222")
        }
    }
}

extension fangjing {
    func compont() -> String {
        return self.fang + jing
    }
}

let f = ddfdfdf()
f.fang = "nb-fang"
print(f.compont())

//类专属的协议
///添加 AnyObject 关键字到协议的继承列表，就可以限制协议只能被类类型采纳
protocol SomeClassOnlyProtocol: AnyObject, fangProtocol {
    // 这里是类专属协议的定义部分
}

//协议合成
//可以列举任意数量的协议，用和符号（&）分开
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person1: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}
let birthdayPerson = Person1(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)

//练习
func berich (_ andProtocol: fangProtocol & jingProtocol) {
    print("fangjing is rich soon")
}

let fj = fangjing()
berich(fj)

//检查协议一致性
///你可以使用 类型转换 中描述的 is 和 as 操作符来检查协议一致性，即是否遵循某协议，并且可以转换到指定的协议类型。检查和转换协议的语法与检查和转换类型是完全一样的

/*
 1、is 用来检查实例是否遵循某个协议，若遵循则返回 true，否则返回 false；
 2、as? 返回一个可选值，当实例遵循某个协议时，返回类型为协议类型的可选值，否则返回 nil；
 3、as! 将实例强制向下转换到某个协议类型，如果强转失败，将触发运行时错误。
 */


protocol HasArea {
    var area: Double {get}
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}
class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}
//Circle，Country，Animal 并没有一个共同的基类，尽管如此，它们都是类，它们的实例都可以作为 AnyObject 类型的值，存储在同一个数组中：
let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 234234),
    Animal(legs: 4)
]

for object in objects {
    if object is HasArea {
        print("yes")
    }else {
        print("no")
    }
}

for object in objects {
    if let objectHas = object as? HasArea {
        print(objectHas.area)
    }else {
        print("no")
    }
}

//可选的协议要求
///在协议中使用 optional 关键字作为前缀来定义可选要求
///在于 Objective-C 打交道的代码中，标记 @objc 特性的协议只能被继承自 Objective-C 类的类或者 @objc 类遵循，其他类以及结构体和枚举均不能遵循这种协议
@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

//可选要求可能并未实现，要使用 可选链式 调用可选方法

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: NSObject, CounterDataSource {
    var fixedIncrement = 2
}

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}

//协议扩展 添加的默认方法，可直接使用
///协议可以通过扩展来为遵循协议的类型提供属性、方法以及下标的实现。通过这种方式，你可以基于协议本身来实现这些功能，而无需在每个遵循协议的类型中都重复同样的实现，也无需使用全局函数
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

//通过协议扩展，所有遵循协议的类型，都能自动获得这个扩展所增加的方法实现而无需任何额外修改：
let generator1 = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("And here's a random Boolean: \(generator.randomBool())")

//提供默认实现

///自定义实现将会替代扩展中的默认实现

extension PrettyTextRepresentable  {
    var prettyTextualDescription: String {
        return textualDescription
    }
}

//为协议扩展 添加限制条件
//使用 where 子句来描述
extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}

let equalNumbers = [100, 100, 100, 100, 100]
let differentNumbers = [100, 100, 200, 100, 200]
//由于数组遵循 Collection 而且整数遵循 Equatable
//因此 equalNumbers 和 differentNumbers 都可以使用 allEqual() 方法
print(equalNumbers.allEqual(), differentNumbers.allEqual())

//如果一个遵循的类型满足了为同一方法或属性提供实现的多个限制型扩展的要求， Swift 会使用最匹配限制的实现。


