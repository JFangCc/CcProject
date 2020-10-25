import UIKit

var str = "Hello, playground"

//嵌套类型


struct BlackjackCard {

    // 嵌套的 Suit 枚举
    enum Suit: Character {
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }
    
//    var s: Character;
//    var suite: Suit {
//        switch s {
//        case "d":
//            return .spades
//        default:
//            return .hearts
//        }
//    }
    
    // 嵌套的 Rank 枚举
    enum Rank: Int {
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .ace:
                return Values(first: 1, second: 11)
            case .jack, .queen, .king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }

    // BlackjackCard 的属性和方法
    let rank: Rank
    var suit: Suit = Suit.hearts
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}

let sss = BlackjackCard(rank: .ten, suit: .hearts).suit
print(sss.rawValue)

let theAceOfSpades = BlackjackCard(rank: .ten, suit: .spades)
print(theAceOfSpades.description)

//引用嵌套类型
///在外部引用嵌套类型时，在嵌套类型的类型名前加上其外部类型的类型名作为前缀：
let heartsSymbol = BlackjackCard.Suit.hearts
print(heartsSymbol, heartsSymbol.rawValue)
