import UIKit

var str = "Hello, playground"

//闭包是自包含的函数代码块，可以在代码中被传递和使用。Swift 中的闭包与 C 和 Objective-C 中的代码块（blocks）以及其他一些编程语言中的匿名函数（Lambdas）比较相似。
///闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值的匿名闭包

//闭包表达式
let names = [2, 54, 4, 24, 65]
func backward(_ a: Int, _ b: Int) -> Bool {
    a > b
}

//逆序排序
var newsort = names.sorted(by: backward)
print(newsort)

//闭包表达式语法
///闭包表达式参数 可以是 in-out 参数，但不能设定默认值。如果你命名了可变参数，也可以使用此可变参数。元组也可以作为参数和返回值。

///闭包的函数体部分由关键字 in 引入。该关键字表示闭包的参数和返回值类型定义已经完成，闭包函数体即将开始。

var newsort1 = names.sorted(by: {(s1: Int, s2: Int) -> Bool in return s1 < s2})
print(newsort1)

//根据上下文推断类型
var newsort2 = names.sorted(by: {s1,s2 in return s1 > s2})
print(newsort2)

//单表达式闭包的隐式返回
var newsort3 = names.sorted(by: {s1,s2 in s1 > s2})
print(newsort3)

//参数名称缩写
var newsort4 = names.sorted(by: {$0 > $1})
print(newsort4)

//运算符方法
var newsort5 = names.sorted(by: >)
print(newsort5)

//尾随闭包
func someFunctionThatTakesAClosure(closure: () -> Void) {
    // 函数体部分
}

// 以下是不使用尾随闭包进行函数调用
someFunctionThatTakesAClosure(closure: {
    // 闭包主体部分
})

// 以下是使用尾随闭包进行函数调用
someFunctionThatTakesAClosure() {
    // 闭包主体部分
}

// 以下是使用尾随闭包进行函数调用，因只有一个参数，可以省略（）
someFunctionThatTakesAClosure {
    // 闭包主体部分
}

newsort5 = names.sorted(){$0 < $1}
print(newsort5)
newsort5 = names.sorted(by: { $0 > $1 })
print("\(newsort5)22222")
//如果闭包表达式是函数或方法的唯一参数，则当你使用尾随闭包时，你甚至可以把 () 省略掉：
newsort5 = names.sorted{$0 < $1}
print(newsort5)

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]
let strings = numbers.map {
    number -> String in
    var number = number
    var output = ""
    repeat{
        output = digitNames[number % 10]! + output
        number /= 10
    }while number > 0
    return output
}
print(strings)

func fangvoid(b:Int,c:String,_ a: (_ b: Int) -> Bool) {
    print(a(4))
}
fangvoid(b: 2,c: "dsds") { (a) -> Bool in a > 0 }
fangvoid(b: 4,c: "dsds",{ (a) -> Bool in return a > 0 })
//fangvoid { a -> Bool in return a > 0 }
//fangvoid { a -> Bool in a > 0 }

//值捕获

///捕获引用保证了 runningTotal 和 amount 变量在调用完 makeIncrementer 后不会消失，并且保证了在下一次执行 incrementer 函数时，runningTotal 依旧存在。
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
let method = makeIncrementer(forIncrement: 10)
print(method())
print(method())
print(method())

//指向闭包的引用 incrementBySeven 是一个常量，而并非闭包内容本身
let incrementBySeven = makeIncrementer(forIncrement: 7)
print(incrementBySeven())
print(method())

//闭包是引用类型
///无论你将函数或闭包赋值给一个常量还是变量，你实际上都是将常量或变量的值设置为对应函数或闭包的引用。上面的例子中，指向闭包的引用 incrementByTen 是一个常量，而并非闭包内容本身。

///上面的例子中，incrementBySeven 和 method 都是常量，但是这些常量指向的闭包仍然可以增加其捕获的变量的值。这是因为函数和闭包都是引用类型。

let alsoIncrementByTen = method
print(alsoIncrementByTen())

//逃逸闭包
var completionHandlers: [()->Void] = []
///someFunctionWithEscapingClosure(_:) 函数接受一个闭包作为参数，该闭包被添加到一个函数外定义的数组中。如果你不将这个参数标记为 @escaping，就会得到一个编译错误。

func someFunctionWithEscapingClosure(completionHandler: @escaping ()->Void){
    completionHandlers.append(completionHandler)
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

//将一个闭包标记为 @escaping 意味着你必须在闭包中显式地引用 self
class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { ()->Void in self.x = 100 }
        someFunctionWithNonescapingClosure { ()->Void in x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)
// 打印出“200”

completionHandlers.first?()
print(instance.x)
// 打印出“100”

//自动闭包
///自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式。这种闭包不接受任何参数，当它被调用的时候，会返回被包装在其中的表达式的值。这种便利语法让你能够省略闭包的花括号，用一个普通的表达式来代替显式的闭包。
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)

let customerProvider = {customersInLine.remove(at: 0)}
let deleateStr = customerProvider()
print(deleateStr)
print(customersInLine.count)

func serve(custom customerProvider: () -> String){
    print("Now serving \(customerProvider())!")
}
serve(custom: customerProvider)
serve(custom: {customersInLine.remove(at: 2)})

///@autoclosure 来接收一个自动闭包。现在你可以将该函数当作接受 String 类型参数（而非闭包）的函数来调用。customerProvider 参数将自动转化为一个闭包，因为该参数被标记了 @autoclosure 特性
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))
//过度使用 autoclosures 会让你的代码变得难以理解。上下文和函数名应该能够清晰地表明求值是被延迟执行的。

let sdsd = {(a:Int) -> Int in return a}
func methods(_ aaa: (Int) -> Int){
    print(aaa(5))
}
print(sdsd(5))
methods(sdsd)

let dddd: (Int) -> Int = sdsd
print(dddd(6))

//如果你想让一个自动闭包可以“逃逸”，则应该同时使用 @autoclosure 和 @escaping 属性。@escaping 属性的讲解见上面的 逃逸闭包。
var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print("Collected \(customerProviders.count) closures.")
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}

