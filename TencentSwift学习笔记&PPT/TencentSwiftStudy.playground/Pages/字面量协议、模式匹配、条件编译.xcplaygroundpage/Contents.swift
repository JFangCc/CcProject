//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//字面量 Literal

//修改字面量的默认类型为Float，本来是Double，不建议修改
typealias FloatLiteralType = Float
var num = 10.99 //Float
print(num)

//通过Int 初始化类
class Person: ExpressibleByIntegerLiteral {
    var score = 0
    required init(integerLiteral value: Int) {
        self.score = value
    }
}
//var p = Person()
//var p1 = Person.init()
var p2 = 200
print(p2)

extension Int: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) {
        self = value ? 1 : 0
    }
}

var num1: Int = true
print(num1)

var dsds = [Int: Int]()
print(dsds)

var sdasdasd = [Int]()
print(sdasdasd)

//模式匹配
var  sdsd: Int? = 20
switch sdsd {
    //?号 表示非空
case let v?:
    print(v)
case nil:
    print("dsdasdasdas")
}

if let ff = sdsd {
    print(ff)
}else {
    print("dsdsdsds")
}


let age = 3
if case 0...9 = age {
    print("yes")
}

switch age {
case 0...9:
    print("yes")
default:
    break
}

let ages:[Int?] = [1, 3, 434, nil, 33]
for case nil in ages {
    print("有nil值")
    break
}

for case let age? in ages {
    print(age)
}

let points = [(2,0), (2,1), (3,0)]
for case let (x, 0) in points {
    print(x)
}


let ss: Int? = 43
if case let x? = ss {
    print(x)
}

//类型判断 is
var num2: Any = 10
switch num2 {
case is Int:
    print("yes, \(num2)")
default:
    break
}

//类型转换 as
switch num2 {
case let n as Int:
    print("yes, \(n)")
default:
    break
}


// 复杂的case匹配调用的 运算符是 ~=
// case并不是所有的匹配调用的运算符都是 ~=
// ~= 格式  pattern:  case 的类型       value: switch值的类型  固定返回 Bool
//func ~= (pattern: (String) -> Bool, value: String) -> Bool
extension String {
    //运算符重载 必须static修饰
    //在'String'扩展名中声明的运算符'〜='必须为'static'
    static func ~= (pattern: (String) -> Bool, value: String) -> Bool {
        pattern(value)
    }
}

func hasPrefix(_ prefix: String) -> ((String) -> Bool) { { $0.hasPrefix(prefix)} }
func hasSuffix(_ suffix: String) -> ((String) -> Bool) { { $0.hasSuffix(suffix)} }

var stree = "123456"
switch stree {
case hasPrefix("123"):
    print("123开头")
case hasSuffix("456"):
    print("456结尾")
default:
    break
}


//条件编译

// 操作系统: macOS/iOS/...
#if os(macOS) || os(iOS)
// CPU架构: i386/x86_64/arm/arm64
#elseif arch(x86_64) || arch(arm64)
// swift版本
#elseif swift(<5) && swift(>=3)
// 模拟器
#elseif targetEnvironment(simulator)
// 可以导入某模块
#elseif canImport(Foundation)

#else
#endif



#if Debug

#else
#endif
//自定义标记 且在DEBUG模式存在
//Build Setting -> 搜swift compiler - custom
// Active Compilation Conditions -> Debug后加+空格+MYTEST(自己的标记)
// Other Swift Flags -> Debug后加 + -D +空格MYTEST(自己的标记)

//文件 方法 行数
print(#file, #line, #function)

var sdsds: NSString = "dsdsdsdsd"
sdsds.appending("3333")
print(sdsds)

var sddddd: String = "dsdsdsdsd"
sddddd.appending("4444")


//系统版本检测
if #available(iOS 10, macOS 10.15.6, *){
    // *表示除了前面的条件，其他平台都支持
}

//API可用性说明——类文件前面
@available(iOS 10, macOS 10.15.6, *)

struct Student {
    //study 方法更换为 studys
    @available(*, unavailable, renamed: "studys")
    func study(){
    }
    //iOS 11 过期
    @available(iOS, deprecated: 11)
    func test(){
    }
}

var s = Student()
s.test()
s.study()
