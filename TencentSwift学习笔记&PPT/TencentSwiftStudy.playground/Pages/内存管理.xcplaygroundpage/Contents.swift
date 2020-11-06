//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//weak、unowned 只能用在类实例上面
//结构体、枚举不支持 weak
//必须是 var 可选类型 才能赋为nil
class Person {
    deinit {
        print("dealloc")
    }
}

weak var p: Person? = Person()
p = nil

func text() {
    var p = Person()
}

text()

//unowned 无主引用
//实例销毁后仍然存储着实例的内存地址，访问无主引用 可能会造成（运行时错误）野指针

//闭包循环引用，捕获列表解决
class Person1 {
    var fn:(() -> ())?
    func run() {
        print("run")
    }
    deinit {
        print("dealloc 111")
    }
}
//造成了循环引用
func test1() {
    let p = Person1()
    p.fn = {
        p.run()
    }
}
test1()

//解决
func test2() {
    let p = Person1()
    p.fn = {
        //捕获列表 写在参数体前面
        [weak p] in
        p?.run()
        //两种写法
//        [unowned p] in
//        p.run()
    }
}
test2()


//闭包的循环强引用
class HTMLElement {

    let name: String
    let text: String?

    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}
func test3() {
    var heading = HTMLElement(name: "h1")
    heading.asHTML()
}
test3()

//逃逸闭包 闭包的调用在函数的作用域之外，可能在函数结束后调用
//@escaping
typealias fn = () -> ()
var fFn: fn?
func test3 (_ fn: @escaping fn) {
    fFn = fn
}
fFn?()


func test4 (_ fn: @escaping fn) {
    //全局并发队列
    DispatchQueue.global().async {
        fn()
    }
}
