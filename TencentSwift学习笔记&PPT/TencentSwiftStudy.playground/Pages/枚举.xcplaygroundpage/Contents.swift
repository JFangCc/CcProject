//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

enum Direction {
    case north
    case south
    case east
    case west
}

enum Direction1 {
    case north(ss: Int), south, east, west
}

var dir = Direction1.west
dir = Direction1.east
dir = .north(ss: 9)
print(dir)

var dir1 = Direction1.west
print(dir1)

switch dir {
case .west:
    print(dir)
case Direction1.north(let kkkk):
    print(kkkk)
default:
    break
}

//关联值
enum Score {
    case point(Int)
    case grade(Character)
}

var score = Score.point(98)
score = .grade("A")

switch score {
case .point(let k):
    print(k)
case .grade(let k):
    print(k)
}

//原始值
enum PokerSuit: Character {
    case spade = "♠️"
    case heart = "♥️"
    case diamond = "♦️"
    case club = "♣️"
}

var suit = PokerSuit.diamond
print(suit)
print(suit.rawValue)
print(PokerSuit.club.rawValue)

//原始值类型是 Int、String，Swift会自动分配原始值
enum Direction2 :String{
    case north
    case south
    case east
    case west
}

//递归枚举 关键字 indirect
indirect enum ArithExpr {
    case number(Int)
    case sum(ArithExpr, ArithExpr)
    case difference(ArithExpr, ArithExpr)
}
//另一种写法
enum ArithExpr1 {
    case number(Int)
    indirect case sum(ArithExpr, ArithExpr)
    indirect case difference(ArithExpr, ArithExpr)
}


//MemorylayOut 获取数据类型占用的内存大小
//alignment 最大内存对齐是8
//Int 类型以下
//MemoryLayout<Int>.size //64位 实际占用的内存大小8
//MemoryLayout<Int>.stride //64位 分配内存的大小8
//MemoryLayout<Int>.alignment //64位 内存对齐是8

var age = 10000
//64 位 Int类型占用内存8个字节
MemoryLayout<Int>.size //8
MemoryLayout.size(ofValue: age) //8

//字符串类型占用16个字节
var str1: String = "a"
MemoryLayout.size(ofValue: str1)

//枚举类型
MemoryLayout<Direction>.size //1 字节
MemoryLayout<Direction1>.size //1 字节

//关联值类型，传进去的参数值是存储到枚举变量内存里的
//原始值类型，原始值是不会存到枚举变量内存里的，实际存储的还是0、1、2、3只会占用内存一个字节

enum test {
    case test1, test2, test3
}

var t = test.test1
t = .test2
t = .test3

print(MemoryLayout<test>.size)
print(MemoryLayout<test>.stride)
print(MemoryLayout<test>.alignment)

print(MemoryLayout.size(ofValue: t))
print(MemoryLayout.stride(ofValue: t))
print(MemoryLayout.alignment(ofValue: t))


enum fangjing{
    case type(Int)
    case type1(Int)
    case type2(Int)
    case type3(Int)
}

let dsds = fangjing.type(6)

switch dsds {
case .type(let sd):
    print(sd)
case.type1(let sd1):
    print(sd1)
case.type2(let sd2):
    print(sd2)
case.type3(let sd3):
    print(sd3)
}


enum fangjing1: Int{
    case type = 1
    case type1
    case type2
    case type3
}

let dsdsdsd = fangjing1.type3
switch dsdsdsd {
    case .type:
    fallthrough
    case .type1:
    fallthrough
    case .type2:
    fallthrough
    case .type3:
    print(dsdsdsd.rawValue)
}

