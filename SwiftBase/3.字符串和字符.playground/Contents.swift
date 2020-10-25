import UIKit

var str = "Hello, playground"

//字符串字面量
let someString = "Some string literal value"

//多行字符串字面量
let quotation = """
tsdsd
sdsdsd aqwe asdsada dsds "sdasdasd" awqw
dsadasdsad "dsdasczxc" dasdas
"""
print(quotation)

let singleLineString = "These are the same."
let multilineString = """
These are the same.
"""
print(singleLineString,multilineString)

///以便加强代码的可读性，但是你又不想在你的多行字符串字面量中出现换行符
let singleLineString1 = """
These are the s\
ame.
"""
print(singleLineString1)

//首行缩进字数以关闭引号位置为准，关闭引号"""不能超过字面量字符串位置，否则会报错
let lineBreaks = """
   This string starts with a line break.
     It also ends with a line break.
"""
print(lineBreaks)

//字符串字面量的特殊字符
///换行符
let linreaks = "wewqewqewqe \n dedede"
///反斜线
let linreaks1 = "wewqewqewqe \\ dedede"
///水平制表符 tab
let linreaks2 = "wewqewqewqe \t dedede"
///回车符
let linreaks3 = "wewqewqewqe\r dedede"
///双引号
let linreaks4 = "wewqewqewqe\"eee\"dedede"
///单引号
let linreaks5 = "wewqewqewqe\'eee\'dedede"
print(linreaks5)

//特殊字符的使用示例
let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
// "Imageination is more important than knowledge" - Enistein
let dollarSign = "\u{24}"             // $，Unicode 标量 U+0024
let blackHeart = "\u{2665}"           // ♥，Unicode 标量 U+2665
let sparklingHeart = "\u{1F496}"      // 💖，Unicode 标量 U+1F496
print(dollarSign,blackHeart,sparklingHeart)

///要在多行字符串字面量中使用 """ 的话，就需要使用至少一个转义符（\）
let threeDoubleQuotes = """
Escaping the first quote \"""
Escaping all three "" quotes ""
"""
print(threeDoubleQuotes)

//## 必须对称才能实现 \转义
let threeMoreDoubleQuotationMark = #"Line 1\nLine 2"# //无换行效果
let threeMoreDoubleQuotationMarks = #"Line 1\#nLine 2"# //有换行效果
let threeMoreDoubleQuotationMark1 = ##"Line 1\##nLine 2"## //有换行效果
print(threeMoreDoubleQuotationMark,threeMoreDoubleQuotationMarks,threeMoreDoubleQuotationMark1)

let threeMoreDoubleQuotationMarks2 = #"""
Here are three more double quotes: \#"""
"""#
print(threeMoreDoubleQuotationMarks2)

//初始化空字符串
var emptyString = ""               // 空字符串字面量
var anotherEmptyString = String()  // 初始化方法
// 两个字符串均为空并等价。
print(emptyString,anotherEmptyString)
if emptyString.isEmpty && anotherEmptyString.isEmpty{
    print("yes")
}

//字符串可变性
var variableString = "Horse"
variableString += " and carriage"
// variableString 现在为 "Horse and carriage"

///常量字符串不可以被修改。
let constantString = "Highlander"
//constantString += " and another Highlander"

//使用字符
for char in "dog🐶" {
    print(char)
}

///字符串可以通过传递一个值类型为 Character 的数组作为自变量来初始化
let catCharacters: [Character] = ["d","o","g","!","🐶"]
let catString = String(catCharacters);
print(catString)

//连接字符串和字符，字符串可以通过加法运算符（+）相加在一起（或称“连接”）创建一个新的字符串
let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2

let exclamationMark: Character = "!"
welcome.append(exclamationMark)
print(welcome)

let badStart = """
one
two
"""
let end = """
three
"""
print(badStart + end)

let goodStart = """
one
two

"""
print(goodStart + end)

//字符串插值
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
print("Write an interpolated string in Swift using \(multiplier).")
print(#"6 times 7 is \#(6 * 7)."#)

//计算字符数量
///如果想要获得一个字符串中 Character 值的数量，可以使用 count 属性：
let unusualMenagerie = "Koala 🐨"
print("unusualMenagerie has \(unusualMenagerie.count) characters")

//访问和修改字符串
let greeting = "abcde"
let c = greeting[greeting.startIndex]
let d = greeting[greeting.index(before: greeting.endIndex)]
let f = greeting[greeting.index(after: greeting.startIndex)]
let g = greeting[greeting.index(greeting.startIndex,offsetBy: greeting.count-1)]
let h = greeting[greeting.index(greeting.endIndex, offsetBy: -(greeting.count-1))]
print(c,d,f,g,h)

///试图获取越界索引对应的 Character，将引发一个运行时错误
//greeting[greeting.endIndex] // error
//greeting.index(after: greeting.endIndex) // error

for index in greeting.indices {
   print("\(greeting[index]) ", terminator: "")
}

//插入和删除
var wewew = "hello"
wewew.append("555555")
print(wewew)
wewew.insert("!", at: wewew.endIndex)
print(wewew)
wewew.insert(contentsOf: " world", at: wewew.index(before: wewew.endIndex))
print(wewew)

wewew.remove(at: wewew.startIndex)
print(wewew)
wewew.removeSubrange((wewew.index(wewew.startIndex, offsetBy: wewew.count-2)..<wewew.endIndex))
print(wewew)

//子字符串
let greeting1 = "Hello, world!"
let indexs = greeting1.firstIndex(of: ",") ?? greeting1.endIndex
let begining = greeting1[..<indexs]
print(begining)
//把结果转化为String以便长期存储
let newString = String(begining)
print(newString)

//比较字符串
///字符串/字符可以用等于操作符（==）和不等于操作符（!=）
let quotation1 = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation1 == sameQuotation {
    print("These two strings are considered equal")
}
///在 Swift 中，字符串和字符并不区分地域（not locale-sensitive）

//前缀/后缀相等
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]

///hasPrefix(_:) 和 hasSuffix(_:) 方法都是在每个字符串中逐字符比较其可扩展的字符群集是否标准相等

var num = 0
for index in 0..<romeoAndJuliet.count {
    if romeoAndJuliet[index].hasPrefix("Act 1") {
        num += 1;
    }
}
print("there is \(num) scenes in Act 1")

var count = 0
for item in romeoAndJuliet {
    if item .hasSuffix("Capulet's mansion") {
        count += 1
    }
}
print("there is \(count) hasSuffix in Capulet's mansion")


