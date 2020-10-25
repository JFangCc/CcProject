import UIKit

var str = "Hello, playground"

//错误处理

//错误处理（Error handling） 是响应错误以及从错误中恢复的过程
//Swift 在运行时提供了抛出、捕获、传递和操作可恢复错误（recoverable errors）的一等支持（first-class support）。

//表示与抛出错误
//错误用遵循 Error 协议的类型的值来表示

enum VendingMachineError: Error {
    case invalidSelection                     //选择无效
    case insufficientFunds(coinsNeeded: Int) //金额不足
    case outOfStock                             //缺货
}

//抛出错误使用 throw 语句
//下面的代码抛出一个错误，提示贩卖机还需要 5 个硬币：
//throw VendingMachineError.insufficientFunds(coinsNeeded: 5)

//处理错误
//调用一个能抛出错误的函数、方法或者构造器之前，加上 try 关键字，或者 try? 或 try! 这种变体，有助于迅速识别代码中会抛出错误的地方

//用 throwing 函数传递错误 一个标有 throws 关键字的函数被称作 throwing 函数
func canThrowErrors() throws -> String {
    return ""
}

func cannotThrowErrors() -> String {
    return ""
}
//一个 throwing 函数可以在其内部抛出错误，并将错误传递到函数被调用时的作用域。
struct Item {
    var price, count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar" : Item(price: 12, count: 7),
        "Chips" : Item(price: 10, count: 4),
        "Pretzels" : Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispending \(name)")
    }
}

let vendClass = VendingMachine()
vendClass.coinsDeposited = 7
do {
    try vendClass.vend(itemNamed: "Pretzels")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print(coinsNeeded)
} catch VendingMachineError.invalidSelection {
    print("wu")
} catch VendingMachineError.outOfStock {
    print("out")
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

/*
 do {
     try expression
     statements
 } catch pattern 1 {
     statements
 } catch pattern 2 where condition {
     statements
 } catch pattern 3, pattern 4 where condition {
     statements
 } catch {
     statements
 }
 */

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}

func nourish(with item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch is VendingMachineError {
        print("Couldn't buy that from the vending machine.")
    }
}

//通用的 catch 语句捕获
do {
    try nourish(with: "Beet-Flavored Chips")
} catch {
    print("Unexpected non-vending-machine-related error: \(error)")
}

//func eat(item: String) throws {
//    do {
//        try vendingMachine.vend(itemNamed: item)
//    } catch VendingMachineError.invalidSelection, VendingMachineError.insufficientFunds, VendingMachineError.outOfStock {
//        print("Invalid selection, out of stock, or not enough money.")
//    }
//}

//将错误转换成可选值
///可以使用 try? 通过将错误转换成一个可选值来处理错误。如果是在计算 try? 表达式时抛出错误，该表达式的结果就为 nil。例如，在下面的代码中，x 和 y 有着相同的数值和等价的含义：
func someThrowingFunction() throws -> Int {
    return 4
}

let x = try? someThrowingFunction()

let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}

print(x!,y!)

//如果对所有的错误都采用同样的方式来处理，用 try?，可选
//func fetchData() -> Data? {
//    if let data = try? fetchDataFromDisk() { return data }
//    if let data = try? fetchDataFromServer() { return data }
//    return nil
//}

func fetchDataFromDisk() throws {
    print("")
}

func fetchDataFromServer() throws {
    print("")
}

//禁用错误传递
var photo = try? loadImage(atPath: "./Resources/John Appleseed.jpg")
func loadImage(atPath: String) throws -> String{
    return("rtetetett")
}

do {
    try loadImage(atPath: "./Resources/John Appleseed.jpg")
} catch {
    photo = nil
}

if photo != nil {
    print(photo)
}else {
    print("no")
}
print(photo)

//指定清理操作
/*
 func processFile(filename: String) throws {
     if exists(filename) {
         let file = open(filename)
         defer {
             close(file)
         }
         while let line = try file.readline() {
             // 处理文件。
         }
         // close(file) 会在这里被调用，即作用域的最后。
     }
 }
 */



