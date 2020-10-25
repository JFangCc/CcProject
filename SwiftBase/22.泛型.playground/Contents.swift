import UIKit

var str = "Hello, playground"

//泛型

///泛型代码让你能根据自定义的需求，编写出适用于任意类型的、灵活可复用的函数及类型。你可避免编写重复的代码，而是用一种清晰抽象的方式来表达代码的意图。
//Array 和 Dictionary 都是泛型集合

//泛型解决的问题
///非泛型函数
///inout 输入输出参数，可改变外部变量值
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")

//swapTwoInts(_:_:) 函数很实用，但它只能作用于 Int 类型。
//如果你想交换两个 String 类型值，或者 Double 类型值，你必须编写对应的函数

//泛型函数
///泛型函数可适用于任意类型，下面是函数 swapTwoInts(_:_:) 的泛型版本，命名为 swapTwoValues(_:_:)：
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}
/*
 func swapTwoInts(_ a: inout Int, _ b: inout Int)
 func swapTwoValues<T>(_ a: inout T, _ b: inout T)
 */

var someInt1 = 3
var anotherInt1 = 2
swapTwoValues(&someInt1, &anotherInt1)
// someInt 现在是 107，anotherInt 现在是 3
print("someInt is now \(someInt1), and anotherInt is now \(anotherInt1)")

var someString = "world"
var anotherString = "hello"
swapTwoValues(&someString, &anotherString)
// someString 现在是“world”，anotherString 现在是“hello”
print("someInt is now \(someString), and anotherInt is now \(anotherString)")


//类型参数
//占位类型 T 是一个类型参数的例子，类型参数指定并命名一个占位类型，并且紧随在函数名后面，使用一对尖括号括起来（例如 <T>）

///类型参数会在函数调用时被实际类型所替换

//命名类型参数

///大多情况下，类型参数具有描述下的名称，例如字典 Dictionary<Key, Value> 中的 Key 和 Value 及数组 Array<Element> 中的 Element，这能告诉阅读代码的人这些参数类型与泛型类型或函数之间的关系。然而，当它们之间没有有意义的关系时，通常使用单个字符来表示，例如 T、U、V，例如上面演示函数 swapTwoValues(_:_:) 中的 T。

//泛型类型
///下面展示如何编写一个非泛型版本的栈，以 Int 型的栈为例：
struct IntStack {
    var items = [Int]()
    //mutating，需要修改结构体的 items 数组
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

//下面是相同代码的泛型版本：
struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
// 栈中现在有 4 个字符串

let fromTheTop = stackOfStrings.pop()
// fromTheTop 的值为“cuatro”，现在栈中还有 3 个字符串
print(fromTheTop)

//泛型扩展
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem).")
}

//类型约束
///类型约束语法
/*
 T：SomeClass的子类    U：必须符合 SomeProtocol 协议
 func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
     // 这里是泛型函数的函数体部分
 }
 */


//类型约束实践
func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}

// 标准库中定义了一个 Equatable 协议，该协议要求任何遵循该协议的类型必须实现等式符（==）及不等符（!=），从而能对该类型的任意两个值进行比较
func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])
print(doubleIndex, stringIndex!)

//关联类型
///关联类型通过 associatedtype 关键字来指定

//关联类型实践
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int {get}
    subscript(i: Int) -> Item {get}
}
/*
 必须可以通过 append(_:) 方法添加一个新元素到容器里。
 必须可以通过 count 属性获取容器中元素的数量，并返回一个 Int 值。
 必须可以通过索引值类型为 Int 的下标检索到容器中的每一个元素。
 */

struct IntStack1: Container {
    // IntStack 的原始实现部分
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // Container 协议的实现部分
    //指定 Item 为 Int 类型，即 typealias Item = Int
    typealias Item = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

 struct Stack1<Element>: Container {
    // Stack<Element> 的原始实现部分
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // Container 协议的实现部分
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

//扩展现有类型来指定关联类型
extension Array: Container {
    
}

var fffff: [Any] = ["sdsdsdsd",3,4,3,"hgghghgh"]
fffff.append(444444)
print(fffff)
print(fffff.count)
print(fffff[5])

//给关联类型添加约束
protocol Container1 {
    //要遵守 Container1 协议，Item 类型也必须遵守 Equatable 协议。
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int {get}
    subscript(i: Int) -> Item{get}
}

//在关联类型约束里使用协议
protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

extension Stack1: SuffixableContainer {
    func suffix(_ size: Int) -> Stack1 {
        var result = Stack1()
        for index in (count - size)..<count {
            result.append(self[index])
        }
        return result
    }
    // 推断 suffix 结果是Stack1
}
var stackOfInts = Stack1<Int>()
stackOfInts.append(10)
stackOfInts.append(20)
stackOfInts.append(30)
let suffix = stackOfInts.suffix(2)
print(suffix.items)
// suffix 包含 20 和 30

extension IntStack1: SuffixableContainer {
    func suffix(_ size: Int) -> Stack1<Int> {
        var result = Stack1<Int>()
        for index in (count-size)..<count {
            result.append(self[index])
        }
        return result
    }
    // 推断 suffix 结果是 Stack<Int>。
}

//泛型 Where 语句
///类型约束 让你能够为泛型函数、下标、类型的类型参数定义一些强制要求。
func allItemsMatch<C1: Container, C2: Container>
    (_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.Item == C2.Item, C1.Item: Equatable {

        // 检查两个容器含有相同数量的元素
        if someContainer.count != anotherContainer.count {
            return false
        }

        // 检查每一对元素是否相等
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }

        // 所有元素都匹配，返回 true
        return true
}

var stackOfStrings1 = Stack1<String>()
stackOfStrings1.push("uno")
stackOfStrings1.push("dos")
stackOfStrings1.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"]

if allItemsMatch(stackOfStrings1, arrayOfStrings) {
    print("All items match.")
} else {
    print("Not all items match.")
}

//具有泛型 Where 子句的扩展
extension Stack1 where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}

if stackOfStrings1.isTop("tres") {
    print("Top element is tres.")
} else {
    print("Top element is something else.")
}

// 报错
/*
 struct NotEquatable { }
 var notEquatableStack = Stack<NotEquatable>()
 let notEquatableValue = NotEquatable()
 notEquatableStack.push(notEquatableValue)
 notEquatableStack.isTop(notEquatableValue)
 */

extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}

if [9, 9, 9].startsWith(42) {
    print("Starts with 42.")
} else {
    print("Starts with something else.")
}

let ssssssss: [String] = ["fang", "fang", "fang"]
if ssssssss.startsWith("fang") {
    print("Starts with fang.")
} else {
    print("Starts with something else.")
}

//具有泛型 Where 子句的关联类型
protocol Container2 {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }

    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
}

protocol ComparableContainer: Container where Item: Comparable { }
extension ComparableContainer where Item == Double {}
extension Container where Item == Int {}

//泛型下标
extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [Item]
        where Indices.Iterator.Element == Int {
            var result = [Item]()
            for index in indices {
                result.append(self[index])
            }
            return result
    }
}

