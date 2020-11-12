//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//面向协议编程
//struct Fj {
//    var string: String
//    init(_ string: String) {
//        self.string = string
//    }
//    var numberCount: Int {
//        var count = 0
//        for c in string where ("0"..."9").contains(c) {
//            count += 1
//        }
//        return count
//    }
//}
//
//extension String {
//    var fj: Fj {
//        Fj(self)
//    }
//}
//
//let sss = "fj123456"
////自定义扩展方法，字符串中的数字个数
//print(sss.fj.numberCount)


//定义泛型
//
struct Fj1<Base> {
    var base: Base
    init(_ base: Base) {
        self.base = base
    }
}

//利用协议扩展前缀属性
protocol FJCompatible{
    
}
extension FJCompatible {
    var fj: Fj1<Self> {
        get{
            Fj1(self)
        }
        set{
            
        }
    }
    static var fj: Fj1<Self>.Type { Fj1<Self>.self }
}

//给字符串扩展功能
//让String拥有fj前缀属性
extension String: FJCompatible {
}

//给String.fj、String().fj 前缀扩展功能
extension Fj1 where Base == String {
    var numberCount: Int {
        var count = 0
        for c in base where ("0"..."9").contains(c) {
            count += 1
        }
        return count
    }
    mutating func run(){
        
    }
    static func test() {
        print("调到了")
    }
}
var sss1 = "fj123456"
//自定义扩展方法，字符串中的数字个数
print(sss1.fj.numberCount)
String.fj.test()
sss1.fj.run()


//给其他类扩展
class Person {}
extension Person: FJCompatible {

}

struct Dog {}
extension Dog: FJCompatible {

}
