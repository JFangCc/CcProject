//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//从 OC 到 Swift

// MARK: - 类似OC的 #pragma mark -
// MARK: 类似OC的 #pragma mark
// TODO: 用于标记未完成的任务
// FIXME: 用于标记待修复的问题
#warning("undo")

func test() {
    //占位
    #warning("undo")
    
    // TODO:
    //可编译通过 但运行报错，用于返回复杂，一时懒得写
    fatalError()
}

test()


//Swift调用OC
//1、新建一个桥接头文件，文件名格式为：{targetName}-Bridging-Header.h
//2、Build Setting -> 搜索bridging，把头文件路径拖进来


//对C语言函数的重命名
@_silgen_name("functionName")
func swift_sum()

//桥接文件相关

//OC调用Swift
//1、继承NSObject
//2、xcode已经默认生成一个用于OC调用Swift的头文件，文件名格式为：{targetName}-Swift.h
//3、Build Setting -> 搜索general（可查看）
//4、必须用 @objc标识要暴露给OC调的成员和构造器，或者用@objcMembers标记整个类成员都可调用


//@objc(name)
//可通过@objc重命名Swift暴露给OC的符号名（类名、属性名、函数名等）

//选择器 Selector
//使用 #selector(name)定义一个选择器
//必须是被@objcMembers 或 @objc 修饰的方法才可以定义选择器


//字符串相关
/*
 1、String 与 NSString 可以互相桥接转换（编译器自动做的）
 2、String 不能桥接转换成 NSMutableString，NSMutableString 可以桥接转换成 String
 */

