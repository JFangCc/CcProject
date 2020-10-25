import UIKit

var str = "Hello, playground"

//Swift 语言提供数组（Array）、集合（Set）和字典（Dictionary）三种基本的集合类型用来存储集合数据。数组是有序数据的集。集合是无序无重复数据的集。字典是无序的键值对的集。

//集合的可变性
///如果创建一个数组、集合或字典并且把它分配成一个变量，这个集合将会是可变的。
///这意味着可以在创建之后添加、修改或者删除数据项。
///如果把数组、集合或字典分配成常量，那么它就是不可变的，它的大小和内容都不能被改变。

//数组（Arrays)
///数组使用有序列表存储同一类型的多个值。相同的值可以多次出现在一个数组的不同位置中。

//构造方法创建数组
var arr = [Int]()
print(arr.count)

arr.append(3)
arr = []
print(arr.count)

arr.append(3)
//创建一个带有默认值的数组
var fourDoubles = Array(repeating: 4.4, count: 4)
var fiveDoubles = Array(repeating: 5.4, count: 5)
print(fiveDoubles)

//通过两个数组相加创建一个数组
var others = fourDoubles+fiveDoubles
print(others)

//用数组字面量构造数组
var shoppingList: [String] = ["ewww","dsdasd","daqe23"]
print(shoppingList)

//访问和修改数组
///使用布尔属性 isEmpty 作为一个缩写形式去检查 count 属性是否为 0
if shoppingList.isEmpty {
    print("The shopping list is empty.")
} else {
    print("The shopping list is not empty.")
}
shoppingList.append("new")
shoppingList += ["dsdsdasdasdasd","23123123123"]
print(shoppingList)

var firstItem = shoppingList[0]
print(firstItem)

shoppingList[0] = "11111"
print(shoppingList)

shoppingList[1..<5] = ["222","333"]
print(shoppingList)

//通过调用数组的 insert(_:at:) 方法在某个指定索引值之前添加数据项：
shoppingList.insert("444", at: shoppingList.count)
shoppingList.remove(at: 0)
shoppingList.insert("555", at: shoppingList.index(before: 5))
print(shoppingList)

let apples = shoppingList.removeLast()
print(apples)

//数组的遍历
for item in shoppingList {
    print(item)
}

///如果同时需要每个数据项的值和索引值，可以使用 enumerated() 方法来进行数组遍历。enumerated() 返回一个由索引值和数据值组成的元组数组。索引值从零开始，并且每次增加一；如果枚举一整个数组，索引值将会和数据值一一匹配。你可以把这个元组分解成临时常量或者变量来进行遍历：
for (index, value) in shoppingList.enumerated(){
    print(index,value)
}

//集合（Sets）
///集合用来存储相同类型并且没有确定顺序的值。当集合元素顺序不重要时或者希望确保每个元素只出现一次时可以使用集合而不是数组。
///
///一个类型为了存储在集合中，该类型必须是可哈希化的——也就是说，该类型必须提供一个方法来计算它的哈希值。一个哈希值是 Int 类型的，相等的对象哈希值必须相同，比如 a == b,因此必须 a.hashValue == b.hashValue。

//Swift 的所有基本类型（比如 String、Int、Double 和 Bool）默认都是可哈希化的，可以作为集合值的类型或者字典键的类型。没有关联值的枚举成员值（在 枚举 有讲述）默认也是可哈希化的。

//a == a(自反性)
//a == b 意味着 b == a(对称性)
//a == b && b == c 意味着 a == c(传递性)


//集合类型语法

///Swift 中的集合类型被写为 Set<Element>，这里的 Element 表示集合中允许存储的类型。和数组不同的是，集合没有等价的简化形式。

//创建和构造一个空的集合
var letters = Set<Character>()
print(letters)

letters.insert("2")
print(letters)
letters = []

var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
print(favoriteGenres)

//访问和修改一个集合
if favoriteGenres.isEmpty {
    print("As far as music goes, I'm not picky.")
} else {
    print("I have particular music preferences.")
}

favoriteGenres.insert("444")
print(favoriteGenres)

if let remove = favoriteGenres.remove("444") {
    print(remove)
}

if !favoriteGenres.contains("444") {
    print("no")
}

let ewewe = "dasdsdasdasd"
if ewewe.contains("dasdsdasdasd") {
    print("yes")
}

//遍历一个集合
for item in favoriteGenres {
    print(item)
}

///Swift 的 Set 类型没有确定的顺序，为了按照特定顺序来遍历一个集合中的值可以使用 sorted() 方法，它将返回一个有序数组，这个数组的元素排列顺序由操作符 < 对元素进行比较的结果来确定。

for item in favoriteGenres.sorted() {
    print(item)
}

//集合操作
let aaa: Set<Int> = [1,2,3,4,5]
let bbb: Set<Int> = [3,4,5,6,7]
//集合交集部分
let ccc = aaa.intersection(bbb)
print(ccc.sorted())
//集合不相交的部分合集
let ddd = aaa.symmetricDifference(bbb)
print(ddd.sorted())
//集合合并
let eee = aaa.union(bbb)
print(eee.sorted())
//根据不在另一个集合中的值创建一个新的集合
let fff = aaa.subtracting(bbb)
print(fff.sorted())
let ggg = bbb.subtracting(aaa)
print(ggg.sorted())
//排序
print(aaa.sorted())

//集合成员关系和相等
let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]
//判断一个集合中的所有值是否也被包含在另一个集合中
houseAnimals.isSubset(of: farmAnimals)
//判断一个集合是否包含另一个集合中所有的值
farmAnimals.isSuperset(of: houseAnimals)
//判断两个集合是否不含有相同的值（是否没有交集）
farmAnimals.isDisjoint(with: cityAnimals)
//判断一个集合是否是另外一个集合的子集合，并且两个集合并不相等。
let bol = houseAnimals.isStrictSubset(of: farmAnimals)
//判断一个集合是否是另外一个集合的父集合，并且两个集合并不相等。
let bol1 = farmAnimals.isStrictSuperset(of: houseAnimals)
print(bol,bol1)

//字典
///字典是一种无序的集合，它存储的是键值对之间的关系，其所有键的值需要是相同的类型，所有值的类型也需要相同
//创建一个空字典，你可以像数组一样使用构造语法创建一个拥有确定类型的空字典：
var dic = [Int: String]()
dic[3] = "wwqwe"
dic = [:]
print(dic)

//用字典字面量创建字典
var dict: [Int:Int] = [1:1,2:2,3:3,4:4,5:5]
print(dict)

var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

//访问和修改字典
if airports.isEmpty {
    print("The airports dictionary is empty.")
} else {
    print("The airports dictionary is not empty.")
}

airports["fang"] = "jing"
print(airports)

///字典的 updateValue(_:forKey:) 方法可以设置或者更新特定键对应的值
if let oldValue = airports.updateValue("jjjjj", forKey: "fang") {
    print(oldValue)
}

if let erer = airports["fang"] {
    print(erer)
}

if airports["fang"] != nil {
    print(airports["fang"]!)
}

airports["fang"] = nil;
print(airports)

if let removedValue = airports.removeValue(forKey: "fang") {
    print(removedValue)
}else{
    print("no")
}

//字典遍历
for (key,value) in airports {
    print(key,value)
}

for item in airports.keys {
    print(item)
}

for item in airports.values {
    print(item)
}

let keyArr = [String](airports.keys.sorted())
print(keyArr)

let valueArr: [String] = [String](airports.values.sorted())
print(valueArr)

