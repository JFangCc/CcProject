import UIKit

var str = "Hello, playground"

//不透明类型
///不透明类型解决的问题
protocol Shape {
    func draw() -> String
}

struct Triangle: Shape {
    var size: Int
    func draw() -> String {
        var result = [String]()
        for length in 1...size {
            result.append(String(repeating: "*", count: length))
        }
        return result.joined(separator: "\n")
    }
}

let smallTriangle = Triangle(size: 3)
print(smallTriangle.draw())
/*
 *
 **
 ***
 */

//垂直翻转
struct FlippedShape<T: Shape>: Shape {
    var shape: T
    func draw() -> String {
        //数组分开
        let lines = shape.draw().split(separator: "\n")
        //数组连接
        return lines.reversed().joined(separator: "\n")
    }
    //默认构造器
    init(shape: T) {
        self.shape = shape
    }
}
let flippedTriangle = FlippedShape(shape: smallTriangle)
print(flippedTriangle.draw())


struct JoinedShape<T: Shape, U: Shape>:Shape {
    var top: T
    var bottom: U
    func draw() -> String {
        return top.draw() + "\n" + bottom.draw()
    }
}

let joinedShape = JoinedShape(top: smallTriangle, bottom: flippedTriangle)
print(joinedShape.draw())

/*
 *
 **
 ***
 ***
 **
 *
 */

//返回不透明类型
struct Square: Shape {
    var size: Int
    func draw() -> String {
        let line = String(repeating: "*", count: size)
        let result = [String](repeating: line, count: size)
        return result.joined(separator: "\n")
    }
}

func makeTrapezoid() -> some Shape {
    let top = Triangle(size: 2)
    let middle = Square(size: 2)
    let bottom = FlippedShape(shape: top)
    let trapezoid = JoinedShape(
        top: top,
        bottom: JoinedShape(top: middle, bottom: bottom)
    )
    return trapezoid
}
let trapezoid = makeTrapezoid()
print(trapezoid.draw())
// *
// **
// **
// **
// **
// *

func flip<T: Shape>(_ shape: T) -> some Shape {
    return FlippedShape(shape: shape)
}
func join<T: Shape, U: Shape>(_ top: T, _ bottom: U) -> some Shape {
    JoinedShape(top: top, bottom: bottom)
}

let opaqueJoinedTriangles = join(smallTriangle, flip(smallTriangle))
print(opaqueJoinedTriangles.draw())
// *
// **
// ***
// ***
// **
// *

//
//func invalidFlip<T: Shape>(_ shape: T) -> some Shape {
//    if shape is Square {
//        return shape // 错误：返回类型不一致
//    }
//    return FlippedShape(shape: shape) // 错误：返回类型不一致
//}

struct FlippedShape1<T: Shape>: Shape {
    var shape: T
    func draw() -> String {
        if shape is Square {
            return shape.draw()
        }
        let lines = shape.draw().split(separator: "\n")
        return lines.reversed().joined(separator: "\n")
    }
}

func `repeat`<T: Shape>(shape: T, count: Int) -> some Collection {
    return Array<T>(repeating: shape, count: count)
}

/// 这种情况下，返回的底层类型会根据 T 的不同而发生变化：但无论什么形状被传入，repeat(shape:count:) 都会创建并返回一个元素为相应形状的数组。尽管如此，返回值始终还是同样的底层类型 [T]， 所以这符合不透明返回类型始终唯一的要求。
let dsdsds = repeatElement(smallTriangle, count: 3)
print(dsdsds)

//不透明类型和协议类型的区别
/*
 1、一个不透明类型只能对应一个具体的类型，即便函数调用者并不能知道是哪一种类型
 2、协议类型可以同时对应多个类型，只要它们都遵循同一协议
 */

func protoFlip<T: Shape>(_ shape: T) -> Shape {
    if shape is Square {
        return shape
    }
    return FlippedShape(shape: shape)
}

// == 两边类型不一致，无法判断
/*
let protoFlippedTriangle = protoFlip(smallTriangle)
let sameThing = protoFlip(smallTriangle)
protoFlippedTriangle == sameThing  // 错误
 */


//相比之下，不透明类型则保留了底层类型的唯一性。
//容器
protocol Container {
    associatedtype Item
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}
// Array 本身实现了 Container协议
extension Array: Container { }

// 错误：有关联类型的协议不能作为返回类型。

//func makeProtocolContainer<T>(item: T) -> Container {
//    return [item]
//}

// 错误：没有足够多的信息来推断 C 的类型。

//func makeProtocolContainer<T, C: Container>(item: T) -> C {
//    return [item]
//}

func makeOpaqueContainer<T>(item: T) -> some Container {
    return [item]
}
let opaqueContainer = makeOpaqueContainer(item: 12)
let twelve = opaqueContainer[0]
print(type(of: twelve))

let fj = makeOpaqueContainer(item: "swift")
let jf = fj[0]
print(type(of: fj))
print(jf, type(of: jf))
//jf 的类型可以被推断出为 String， 这说明了类型推断适用于不透明类型
