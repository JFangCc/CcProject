import UIKit

var str = "Hello, playground"

//下标可以定义在类、结构体和枚举中，是访问集合、列表或序列中元素的快捷方式。

//下标语法
///定义下标使用 subscript 关键字
/*
subscript(index: Int) -> Int {
    get {
        //返回一个值
    }
    set {
        //执行赋值操作
        print(newValue)
    }
}
 */

//subscript(index: Int) -> Int {
//    // 返回一个适当的 Int 类型的值
//}
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")
// 打印“six times three is 18”
///TimesTable 例子基于一个固定的数学公式，对 threeTimesTable[someIndex] 进行赋值操作并不合适，因此下标定义为只读的。

//下标用法
var numberDic = ["dsds":5, "sdsw3":6, "dsdds":3]
numberDic["dsds"] = 4
let dsds = numberDic["dsds"]
print(dsds!)

//下标选项
///一个类或结构体可以根据自身需要提供多个下标实现，使用下标时将通过入参的数量和类型进行区分，自动匹配合适的下标。它通常被称为下标的重载。
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            // assert 断言在下标越界时触发：
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1
matrix[1, 0] = 2
print(matrix[1,1])

//类型下标
///结构体和枚举类型，在 subscript 关键字前 使用 static 关键字来表示 类型下标
///在类类型前 使用 class 表示类型下标
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}
//枚举取值
let plant = Planet(rawValue: 4)
let plant1 = Planet.mars
let mars = Planet[4]
print(plant!, plant1, mars)

//类类型下标
class fang {
    var t:Int = 0
    class subscript(nnn: Int) -> Int{
        return nnn
    }
}
print(fang[5])

//实例类型下标
class fang1 {
    var t = 0
    subscript(nnn: Int) -> Int{
        t += nnn
        return t
    }
    init(jing: Int) {
        t = jing
    }
}
let fang2 = fang1(jing: 6)
print(fang2[6])

