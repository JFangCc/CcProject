//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//自定义错误
class MyError: Error {
    var msg: String
    init(msg: String) {
        self.msg = msg
    }
}
struct MyError1: Error {
    var msg: String
}

enum SomeError: Error {
    case zero(String)
    case outOfMemory
}

//异常处理
//throws 表示函数有可能抛出错误
func divide(_ num1: Int, _ num2: Int) throws -> Int {
    if num2 == 0 {
        throw SomeError.zero("0不能作为除数")
    }
    return num1/num2
}
// throws 函数 必须使用 try 调用
//var di = try divide(30, 0)
//print(di)

/* 错误处理
do {
    try <#throwing expression#>
} catch <#pattern#> {
    <#statements#>
}
 */

func test() {
    do {
        print(try divide(30, 0))
    } catch SomeError.zero(let msg) {
        print(msg)
    }catch SomeError.outOfMemory {
        print("内存溢出")
    }catch{
        
    }
}

test()

// throws抛给调用函数，顶层函数未处理 会抛给系统
func test1() throws {
    print(try divide(30, 2))
}
//未处理
try test1()


//try?、try!
func test2() {
    print("1")
    var result1 = try? divide(30, 3);
    var result2 = try? divide(32, 0);
    var result3 = try! divide(35, 7);
    print(result1,result2,result3)
    print("2")
}

test2()

var d = try? divide(5, 0)
print(d)


//rethrows  函数本身不会抛出错误，但调用闭包参数抛出错误，那么它会将错误向上抛
func exec(_ fn: (Int, Int) throws -> Int, _ num: Int) rethrows {
    print(try fn(3, 2))
}

try exec({ (num1: Int, num2: Int) throws -> Int in
    num1 + num2
}, 6)


//defer
//用来定义以任何方式（抛错误、return等）离开代码块前必须要执行的代码
//defer语句将延迟至当前作用域结束之前执行
//defer语句的执行顺序和定义顺序相反

//断言 assert
//Debug模式才会生效，用于调试

func divide2(_ num1: Int, _ num2: Int) -> Int {
    assert(num2 != 0, "0不能作为除数")
    return num1/num2
}

print(divide2(20, 4))

//Build Settings -> Swift Flags
//-assert-config Release 强制关闭断言
//-assert-config Debug 强制开启断言


//fatalError 不希望别人调用 直接报运行错误退出
func divide3(_ num1: Int, _ num2: Int) -> Int {
    if(num2 != 0){
        return num1/num2
    }
    fatalError("0不能作为除数")
}
print(divide2(20, 0))
