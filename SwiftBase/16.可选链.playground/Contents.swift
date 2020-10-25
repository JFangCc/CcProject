import UIKit

var str = "Hello, playground"

//可选链

//可选值为nil，则可选链也返回 nil，可选链式任意一值为nil，则整个可选链式都为 nil
//可选链式调用代替强制解包

//它们的主要区别在于当可选值为空时可选链式调用只会调用失败，然而强制解包将会触发运行时错误。

class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

let fang = Person()
let dsds = fang.residence?.numberOfRooms;
if let wwww = dsds {
    print(wwww)
}else{
    print("dsadas")
}


if let roomCount = fang.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

let roomCount3 = fang.residence
print(roomCount3?.numberOfRooms)

fang.residence = Residence()
if let roomCount1 = fang.residence?.numberOfRooms {
    print("John's residence has \(roomCount1) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

//为可选链式调用定义模型类
class Person1 {
    var residence: Residence1?
}

class Residence1 {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else {
            return nil
        }
    }
}

//通过可选链式调用访问属性

let john = Person1()
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress

func createAddress() -> Address {
    print("Function was called.")

    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"

    return someAddress
}
//可选链式调用失败时，等号右侧的代码不会被执行
john.residence?.address = createAddress()
//没有任何打印消息，可以看出 createAddress() 函数并未被执行。


//通过可选链式调用来调用方法，该方法的返回类型会是 Void?，而不是 Void
if john.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}

if (john.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.")
}

//通过可选链式调用访问下标
if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}

let johnsHouse = Residence1()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnsHouse

if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}

class sdsd {
    var dsdsd: String?
}
let dsadas = sdsd()
if let aaa = dsadas.dsdsd {
    print(aaa)
}else {
    print("222")
}

//访问可选类型的下标
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72
// "Dave" 数组现在是 [91, 82, 84]，"Bev" 数组现在是 [80, 94, 81]
print(testScores)
testScores["fang"] = [45]
print(testScores)
testScores.remove(at: testScores.index(testScores.startIndex, offsetBy: 2))
print(testScores)

//连接多层可选链式调用
if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
// 打印“Unable to retrieve the address.”


let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
john.residence?.address = johnsAddress

if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}

//在方法的可选返回值上进行可选链式调用
if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier).")
}

if let beginsWithThe =
    john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
        if beginsWithThe {
            print("John's building identifier begins with \"The\".")
        } else {
            print("John's building identifier does not begin with \"The\".")
        }
}
