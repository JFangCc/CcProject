import UIKit

var str = "Hello, playground"

//类型转换
//类型转换可以判断实例的类型，也可以将实例看做是其父类或者子类的实例。
// is 和 as 操作符实现

//为类型转换定义类层次
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}
//基类
class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]
// 数组 library 的类型被推断为 [MediaItem]
print(library)
let dsd = library[0]
// MediaItem 类型
print(dsd)

//检查类型
// 类型检查操作符  is  属于某类型则返回 true or false
var moviecount = 0
var songcount = 0
for item in library {
    if item is Movie{
        moviecount += 1
    }else if item is Song {
        songcount += 1
    }
}
print(moviecount, songcount)

for index in 0 ..< library.count {
    if library[index] is Movie {
        moviecount -= 1
    }else if library[index] is Song {
        songcount -= 1
    }
}
print(moviecount, songcount)

//向下转型
///某类型的一个常量或变量可能在幕后实际上属于一个子类。当确定是这种情况时，你可以尝试用类型转换操作符（as? 或 as!）向下转到它的子类型。
for item in library {
    //转换没有真的改变实例或它的值。根本的实例保持不变；只是简单地把它作为它被转换成的类型来使用。
    if let movie = item as? Movie {
        print(movie.director)
    }else if let song = item as? Song {
        print(song.artist)
    }
}

let sss = dsd as! Movie
print(sss.name)

//Any 和 AnyObject 的类型转换
///Any 可以表示任何类型，包括函数类型。
///AnyObject 可以表示任何类类型的实例。

//最好还是在代码中指明需要使用的类型。
var things = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        // is 类型判断/检查
        print("some other double value that I don't want to print")
    case let someString as String:
        // as 类型判断 并赋值
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}

// zero as an Int
// zero as a Double
// an integer value of 42
// a positive double value of 3.14159
// a string value of "hello"
// an (x, y) point at 3.0, 5.0
// a movie called Ghostbusters, dir. Ivan Reitman
// Hello, Michael

//Any 类型可以表示所有类型的值，包括可选类型。Swift 会在你用 Any 类型来表示一个可选值的时候，给你一个警告。如果你确实想使用 Any 类型来承载可选值，你可以使用 as 操作符显式转换为 Any，如下所示：

let optionalNumber: Int? = 3
things.append(optionalNumber)        // 警告
things.append(optionalNumber as Any) // 没有警告
things.append("dsdsds")
things .insert("11111", at: things.index(0, offsetBy: 11))
print(things)
