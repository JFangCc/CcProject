let age: Int
age = 10
print(age)

let error = (404, "Not Found")
error.0
error.1

let (aaa, bbb) = error
print(aaa, bbb)

let http200Status = (status: 200, description: "OK")
print(http200Status.status, http200Status.description)

for _ in 0..<4 {
    print("Swift")
}

let range: ClosedRange<String> = "aa"..."ff"
print(range.contains("cd"))

//间隔区间
// to 不包括
// through 贯穿 包括
for ddd in stride(from: 1, to: 10, by: 1) {
    print(ddd)
}
for ddd in stride(from: 1, through: 10, by: 1) {
    print(ddd)
}

let string = "Jack"
switch string {
case "Jack":
    //贯穿
    fallthrough
case "Rose":
    print("12121212")
default:
    break
}


func goToWork(at time: String) {
    print(time)
}
goToWork(at: "10:00")

//默认参数
func defaultFun(a: String = "aaa", b: Int, c: Int = 10) {
    print(a + "\(b)" + "\(c)")
}
defaultFun(b: 12,c:45)

//可变参数
func sum(_ numbers: Int...) -> Int {
    var total = 0
    for number in numbers {
        total += number
    }
    return total
}
print(sum(1,2,3,4,5))
//紧跟在可变参数后面的参数是不可省略参数标签的
//报错
//func sss(_ a: Int..., _ b: String, c: String) {
//
//}

print("1","2","3")

//输入输出参数
var number = 10
func add(_ number: inout Int) {
    number = 20
}
add(&number)
print(number)

// inout 参数只能是变量
// inout 参数不能有默认值
// inout 参数本质是地址传递 (引用传递)

//函数重载要求
//1、函数名相同
//2、参数类型、标签、个数 有一个不同

//relase模式会默认开启内联优化

//永远不会被内联
@inline(never) func test() {
    print("test")
}
//开启编译器优化后，即使代码很长，也会被内联（递归调用、动态派发的函数除外）
@inline(__always) func test1() {
    print("test")
}

