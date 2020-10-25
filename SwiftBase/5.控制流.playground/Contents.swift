import UIKit

var str = "Hello, playground"

//For-In 循环
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}
///字典的内容理论上是无序的，遍历元素时的顺序是无法确定的。将元素插入字典的顺序并不会决定它们被遍历的顺序。关于数组和字典的细节，参见 集合类型。

let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}

for (index,value) in names.enumerated() {
    print(index,value)
}

for index in 1...5 {
    print("\(index) times 5 is \(index*5)")
}

///如果你不需要区间序列内每一项的值，你可以使用下划线（_）替代变量名来忽略这个值：
var num = 0
for _ in 1...5 {
    num += 1
}
print(num)

///半开区间
let minutes = 60
for tickMark in 0..<minutes {
    print(#"\#t\#(tickMark)\#n"#)
}

let interval = 10
//不包括60的 半开区间 使用 stride(from:to:by:) 函数跳过不需要的标记
for index in stride(from: 0, to: minutes, by: interval) {
    print("\(index)")
}

//包括60的 闭区间 可以在闭区间使用 stride(from:through:by:) 起到同样作用：
for index in stride(from: 0, through: minutes, by: interval) {
    print("\(index)")
}

//While 循环
///while 循环会一直运行一段语句直到条件变成 false。这类循环适合使用在第一次迭代前，迭代次数未知的情况下。
///Swift 提供两种 while 循环形式：
///1、while 循环，每次在循环开始时计算条件是否符合
///2、repeat-while 循环，每次在循环结束时计算条件是否符合。

var mun = 0
while mun < 10 {
    mun += 1
    print(mun)
}

//下面的例子来玩一个叫做蛇和梯子（也叫做滑道和梯子）的小游戏：
///游戏盘面可以使用一个 Int 数组来表达。数组的长度由一个 finalSquare 常量储存，用来初始化数组和检测最终胜利条件。游戏盘面由 26 个 Int 0 值初始化，而不是 25 个（由 0 到 25，一共 26 个）：

let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)

///一些方格被设置成特定的值来表示有蛇或者梯子。梯子底部的方格是一个正值，使你可以向上移动，蛇头处的方格是一个负值，会让你向下移动：
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
///所处的方格步数
var square = 0
///骰子的点数
var diceRoll = 0
var sssss = 0
while square < finalSquare {
    //掷骰子🎲
    diceRoll += 1
    if diceRoll == 7 {
        diceRoll = 1
    }
    square += diceRoll
    if square < board.count {
        /// 如果玩家还在棋盘上，顺着梯子爬上去或者顺着蛇滑下去
        square += board[square]
    }
    sssss += 1
}
print("game over \(sssss) 次")

//Repeat-While
var rrrr = 0
repeat {
    rrrr += 1
} while rrrr < 10
print(rrrr)

//If
var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
}

//Switch
///每一个 case 分支都必须包含至少一条语句。像下面这样书写代码是无效的，因为第一个 case 分支是空的：

let someCharacter: Character = "z"
switch someCharacter {
case "a":
    print("The first letter of the alphabet")
case "z":
    print("The last letter of the alphabet")
case "b","c":
    print("bc")
default:
    print("Some other character")
}

let approximateCount = 50
let countedThings = "fang jing"
let naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")

//元组
///我们可以使用元组在同一个 switch 语句中测试多个值。元组中的元素可以是值，也可以是区间。另外，使用下划线（_）来匹配所有可能的值。
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case ((-2...2), (-2...2)):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside of the box")
}

let anotherPoint = (2,0)
switch anotherPoint {
case (1...5, let y):
    print("1111 \(y)")
case (0, let x):
    print("2222")
case let(1...5, y):
    print("3333")
default:
    print("4444")
}

//Where
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x,y) where x == y:
    print("\(x) = \(y)")
case let (x,y) where x == -y:
    print("\(x) = \(y)")
default:
    print("is just some arbitrary point")
}

//复合型 Cases
let someCharacter1: Character = "e"
switch someCharacter1 {
case "a", "e", "i", "o", "u":
    print("\(someCharacter1) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
     "n","p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter1) is a consonant")
default:
    print("\(someCharacter1) is not a vowel or a consonant")
}
// 输出“e is a vowel”

let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}
// 输出“On an axis, 9 from the origin”

//复合case值绑定，必须使用统一变量值 x
let vcvc = (5,9)
switch vcvc {
case (let x, 0),(let x,9),(8,let x):
    print("yes\(x)")
default:
    print("eweqwe")
}

//控制转移语句
//控制转移语句改变你代码的执行顺序，通过它可以实现代码的跳转。Swift 有五种控制转移语句：
//continue
//break
//fallthrough
//return
//throw

//Continue
///continue 语句告诉一个循环体立刻停止本次循环，重新开始下次循环。就好像在说“本次循环我已经执行完了”，但是并不会离开整个循环体

let puzzleInput = "great minds think alike"
var puzzleOutput = ""
for char in puzzleInput {
    switch char {
    case "g","r","e","a","t"," ":
        continue
    default:
        puzzleOutput.append(char)
    }
}
print(puzzleOutput)

//Break
///break 语句会立刻结束整个控制流的执行。break 可以在 switch 或循环语句中使用，用来提前结束 switch 或循环语句。
for char in puzzleInput {
    if char == "g"{
        break
    }
    print("wwwwww")
}

let numberSymbol: Character = "三"  // 简体中文里的数字 3
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break
}
if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value could not be found for \(numberSymbol).")
}

//贯穿（Fallthrough）
let uuu = 6
var ffff: Int?
switch uuu {
case 1,2,3,6:
    ffff = uuu
    fallthrough
default:
    ffff = 9
}
if let ddd = ffff {
    print(ddd)
}

//带标签的语句
///前导关键字（introducor keyword）fangjing、ddddd
var rtrt = 0
fangjing: while rtrt < 20 {
    rtrt += 1
    ddddd: switch rtrt {
    case 10:
        print("10")
        break fangjing
    case 19:
        print("19")
        break ddddd
    default:
        continue fangjing
    }
}

//提前退出
///如果 guard 语句的条件被满足，则继续执行 guard 语句大括号后的代码。将变量或者常量的可选绑定作为 guard 语句的条件，都可以保护 guard 语句后面的代码。

func method (a : [String:String]){
    guard let b = a["name"] else {
        return
    }
    print(b)
}
method(a: ["name":"fangjing"])

//检测 API 可用性
if #available(iOS 12, *) {
    print("12")
}else {
    print("else")
}

if #available(iOS 10, macOS 10.12, *) {
    // 在 iOS 使用 iOS 10 的 API, 在 macOS 使用 macOS 10.12 的 API
} else {
    // 使用先前版本的 iOS 和 macOS 的 API
}
