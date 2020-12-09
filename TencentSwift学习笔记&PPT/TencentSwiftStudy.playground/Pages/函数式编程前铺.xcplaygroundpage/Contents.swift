//: [Previous](@previous)

import Foundation
import UIKit

var str = "Hello, playground"

//: [Next](@next)

var subStr = str[str.startIndex..<str.index(str.startIndex, offsetBy: 5)]
print(str, subStr)
subStr.append(contentsOf: "wwww")
str = String(subStr)
print(str)

//只能被类遵守
@objc protocol Run {
    @objc optional func run()
}

class ddd: Run {
    func run() {
        
    }
}

//被 @objc dynamic 修饰的内容具有动态性，比如调用方法会走runtime那一套流程
class Dog: NSObject {
    @objc dynamic func test(){
        
    }
    func test2() {
        
    }
}
var d = Dog()
d.test()
d.test2()


// KVC\KVO
// 属性所在的类、监听器必须最终继承 NSObject
// 用@objc dynamic 修饰对应的属性（使其具有OC的动态性，runtime那一套流程）


//扩展不可以增加存储属性
//关联对象 可以实现为类扩展存储属性的效果
class Person{
}

extension Person{
    //类型存储属性 本质是全局变量
    // AGE_KEY 只是作为存储地址，能节省内存就省内存，Bool类型只占一个字节 就可以 或者 Void? 也是占一个字节
    private static var AGE_KEY: Bool = false
    private static var WEIGHT_KEY: Bool = false
    var age: Int {
        get{
            objc_getAssociatedObject(self, &Self.AGE_KEY)! as! Int
        }
        set {
            objc_setAssociatedObject(self, &Self.AGE_KEY, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    var wight: Int {
        get{
            objc_getAssociatedObject(self, &Self.WEIGHT_KEY)! as! Int
        }
        set {
            objc_setAssociatedObject(self, &Self.WEIGHT_KEY, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}

var p = Person()
p.age = 100
p.wight = 200
print(p.age, p.wight)

//资源名管理
let img = UIImage(named: "logo")
let btn = UIButton(type: .custom)
btn .setTitle("fjfj", for: .normal)


extension UIImage {
    convenience init?(_ name: R.image){
        self.init(named: name.rawValue)
    }
}

enum R {
    enum string: String {
        case add = "添加"
    }
    enum image: String {
        case logo
    }
    enum segue: String {
        case login_main
    }
}
print(R.image.logo, R.image.logo.rawValue)
let img1 = UIImage(R.image.logo)
print(img1)



enum R2 {
    enum image {
        static var logo = UIImage(named: "logo")
    }
    enum font {
        static func arial(_ size: CGFloat) -> UIFont? {
            UIFont(name: "Arial", size: size)
        }
    }
}
let img2 = R2.image.logo
let font = R2.font.arial(18)
print(img2, font)


//多线程开发
DispatchQueue.global().async {
    print(Thread.current, "async")
    DispatchQueue.main.async {
        //回到主线程
    }
}
// DispatchWorkItem 方式
let item = DispatchWorkItem {
    print(Thread.current, "item")
}
DispatchQueue.global().async(execute: item)
item.notify(queue: DispatchQueue.main) {
    
}

//Array 常见操作
var arr = [1, 2, 3, 4]
//$0 上一次遍历返回的结果（初始值是0）
//$1 每次遍历到的数组元素
var arr1 = arr.reduce(0) { $0 + $1 }
print(arr1)
var arr2 = arr.reduce(10) { $0 + $1 }
print(arr2)
//每个元素都 * 3
var arr3 = arr.map { $0 * 3 }
print(arr3)
//筛选
var arr4 = arr.filter { $0 % 2 == 0 }
print(arr3)

var arr5 = Array.init(repeating: 6, count: 2)
print(arr5)

var arr6 = arr.map { Array.init(repeating: $0, count: $0) }
print(arr6)

var arr7 = arr.flatMap { Array.init(repeating: $0, count: $0) }
print(arr7)

var arr0 = ["222", "sddd", "123", "ss54gg"]
//转为整数
var arr8 = arr0.map{ Int($0) }
//转为整数 去除nil
var arr9 = arr0.compactMap{ Int($0) }
print("\(arr8) \n\(arr9)")

//可选类型的Map 和 flatMap
var num: Int? = 10
var num1 = num.map{ $0 * 2 }
var num0 = num.map{ Optional.some($0*2) }
//flatMap 发现是可选类型 就不会再包装一层
var num2 = num.flatMap{ Optional.some($0*2) }

print(num1)
print(num0)
print(num2)

var ddfdf = [1,1,13,3,4,4,4,45]
ddfdf.removeAll(keepingCapacity: true)
ddfdf.append(contentsOf: 1...100)
ddfdf.removeLast(10)
ddfdf.swapAt(ddfdf.startIndex, ddfdf.endIndex-1)
print(ddfdf)

var ddfdf1 = [1,5,7,5,7,8,9,45]
let index = ddfdf1.partition { dnum -> Bool in
    dnum > 5
}
print("mmmmm index = \(index)")
let p2221 = ddfdf1[..<index]
let p3332 = ddfdf1[index...]
print(p2221,p3332)

var ddddd: String = "dsdsdsd"
ddddd.insert(contentsOf :"eeee", at: ddddd.endIndex)
ddddd.insert(contentsOf: "fffff", at: ddddd.index(before: ddddd.endIndex))
print(ddddd)

var num3: Int? = nil
var num4 = num3.map{ Optional.some($0*2) }
var num5 = num3.flatMap{ Optional.some($0*2) }
print(num4)
print(num5)


struct Person1 {
    var name: String
    var age: Int
    init?(_ json: [String : Any]) {
        guard let name = json["name"] as? String, let age = json["age"] as? Int else {
            return nil
        }
        self.name = name
        self.age = age
    }
}



var json: Dictionary? = ["name": "fangjing", "age": 29]
var p1 = json != nil ? Person1(json!) : nil
var p2 = json.map(Person1.init)
var p3 = json.flatMap(Person1.init)
print(p1, p2, p3)
