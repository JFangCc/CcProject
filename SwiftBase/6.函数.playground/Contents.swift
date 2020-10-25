import UIKit

var str = "Hello, playground"

//函数的定义与调用
func greet (person: String)-> String {
    let greeting = "hello" + person + "!"
    return greeting
}
print(greet(person: " fangjing"))

//函数参数与返回值
///函数参数与返回值在 Swift 中非常的灵活。你可以定义任何类型的函数，包括从只带一个未名参数的简单函数到复杂的带有表达性参数名和不同参数选项的复杂函数。
//无参数函数，函数可以没有参数。下面这个函数就是一个无参数函数，当被调用时，它返回固定的 String 消息：
func say() -> String{
    return "fuck"
}
print(say())

//多参数函数
///函数可以有多种输入参数，这些参数被包含在函数的括号之中，以逗号分隔。
func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greet(person: person)
    } else {
        return greet(person: person)
    }
}
print(greet(person: " Tim", alreadyGreeted: true))

//无返回值函数——实际返回一个 Void 类型特殊值，该值为一个空元组，写成 ()。
func greet1(person: String) {
    print("Hello, \(person)!")
}
greet1(person: "Dave")

func printAndCount(string: String) -> Int {
    print(string)
    return string.count
}
func printWithoutCounting(string: String) {
    let _ = printAndCount(string: string)
}
printAndCount(string: "hello, world")
printWithoutCounting(string: "hello, world")

//多重返回值函数
///你可以用元组（tuple）类型让多个值作为一个复合值从函数中返回。
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
let (x, y) = minMax(array: [1,2,3,4,5,6,7])
print(x,y)

//可选元组返回类型
func minMax1(array:[Int]) -> (min:Int,max:Int)?{
    if array.isEmpty{
        return nil
    }
    var currentMin = array[0]
    var currentMax = array[0]
    for item in array {
        if item < currentMin {
            currentMin = item
        } else if item > currentMax {
            currentMax = item
        }
    }
    return (currentMin,currentMax)
}
if let ddd = minMax1(array: [2,434,34,34,3,43,4]) {
    print(ddd.min,ddd.max)
}

//隐式返回的函数
func greesrsd(for person: String) -> String{
    "adsasda" + person + "!"
}
func greeswwwrsd(person: String) -> String{
    "adsasda" + person + "!"
}
print(greesrsd(for: "ffffff"))
print(greeswwwrsd(person: "ffffff"))

//函数参数标签和参数名称
func someFunction(firstParameterName: Int, secondParameterName: Int) {
    // 在函数体内，firstParameterName 和 secondParameterName 代表参数中的第一个和第二个参数值
}
someFunction(firstParameterName: 1, secondParameterName: 2)
///所有的参数都必须有一个独一无二的名字。虽然多个参数拥有同样的参数标签是可能的，但是一个唯一的参数标签能够使你的代码更具可读性。

//指定参数标签 你可以在参数名称前指定它的参数标签，中间以空格分隔：
func someFunction(label parameterName: Int) {
    // 在函数体内，parameterName 代表参数值
    // 在函数体内, label 代表参数标签
}

func greerr (person :String, from home :String) -> String{
    ("\(person) from home \(home)")
}
print(greerr(person: "fangjing", from: "xinyang"))

//忽略参数标签
func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
     // 在函数体内，firstParameterName 和 secondParameterName 代表参数中的第一个和第二个参数值
}
someFunction(4, secondParameterName: 3)

//默认参数值
///你可以在函数体中通过给参数赋值来为任意一个参数定义默认值（Deafult Value）。当默认值被定义后，调用这个函数时可以忽略这个参数。
func someFunction1(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    // 如果你在调用时候不传第二个参数，parameterWithDefault 会值为 12 传入到函数体中。
}
someFunction1(parameterWithoutDefault: 4)
someFunction1(parameterWithoutDefault: 5, parameterWithDefault: 7)

//可变参数
//一个函数最多只能拥有一个可变参数。
func arithmeticMean (_ numbers: Double...) -> Double {
    if numbers.count == 0 {
        return 0
    }
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
//可传多个参数
print(arithmeticMean(1.3,43.44,223.0,3.4))
//可传空、0个参数
print(arithmeticMean())

//输入输出参数
//inout 你只能传递变量给输入输出参数。你不能传入常量或者字面量，因为这些量是不能被修改的。当传入的参数作为输入输出参数时，需要在参数名前加 & 符，表示这个值可以被函数修改。
func sssddd(a:inout Int,b:inout Int){
    let temporaryA = a
    a = b
    b = temporaryA
    print(a,b)
}
var someInt = 3
var anotherInt = 107
sssddd(a: &someInt, b: &anotherInt)
print(someInt,anotherInt)

//函数类型
///每个函数都有种特定的函数类型，函数的类型由函数的参数类型和返回类型组成。

//这两个函数的类型是 (Int, Int) -> Int
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
//(Int, Int) -> Int
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}
//() -> Void，或者叫“没有参数，并返回 Void 类型的函数
func printHelloWorld() {
    print("hello, world")
}

//使用函数类型
var mathodFunction:(Int,Int)->Int = addTwoInts
print(mathodFunction(32334,3545))

mathodFunction = multiplyTwoInts
print(mathodFunction(4,3))

let function = mathodFunction
print(function(5,6))

//函数类型作为参数类型
///你可以用 (Int, Int) -> Int 这样的函数类型作为另一个函数的参数类型。这样你可以将函数的一部分实现留给函数的调用者来提供。
func printMathResult(_ math:(Int,Int) -> Int, _ a:Int, _ b:Int){
    print(math(a, b))
}
printMathResult(addTwoInts, 5, 8)

//函数类型作为返回类型
///你可以用函数类型作为另一个函数的返回类型。你需要做的是在返回箭头（->）后写一个完整的函数类型。
func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}

func chooseStepFunction (back: Bool) -> (Int) -> Int {
    return back ? stepForward : stepBackward
}
var value = 4
let meth = chooseStepFunction(back: value < 0)
print(meth(5))

while value != 0 {
    value = meth(value)
    print(value)
}

//嵌套函数
///到目前为止本章中你所见到的所有函数都叫全局函数（global functions），它们定义在全局域中。你也可以把函数定义在别的函数体中，称作 嵌套函数（nested functions）。
///默认情况下，嵌套函数是对外界不可见的，但是可以被它们的外围函数（enclosing function）调用。一个外围函数也可以返回它的某一个嵌套函数，使得这个函数可以在其他域中被使用。

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int {
        return input + 1
    }
    func stepBackward(input: Int) -> Int {
        return input - 1
    }
    return backward ? stepBackward : stepForward
}
var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
