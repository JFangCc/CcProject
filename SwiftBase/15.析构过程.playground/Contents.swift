import UIKit

var str = "Hello, playground"

//析构过程
///析构器用关键字 deinit 来标示，类似于构造器要用 init 来标示。

//析构过程原理
/*
 deinit {
     // 执行析构过程
 }
 */

//Swift 会自动释放不再需要的实例以释放资源
//在类的定义中，每个类最多只能有一个析构器，而且析构器不带任何参数和圆括号，如下所示：
//析构器是在实例释放发生前被自动调用的。你不能主动调用析构器

class Bank {
    static var coinsInBank = 10_000
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}

class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    deinit {
        Bank.receive(coins: coinsInPurse)
    }
}

var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
print("There are now \(Bank.coinsInBank) coins left in the bank")

playerOne!.win(coins: 2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
print("The bank now only has \(Bank.coinsInBank) coins left")

//实例被释放，以便回收内存。在这之前，该实例的析构器被自动调用，玩家的硬币被返还给银行。
playerOne = nil
print("PlayerOne has left the game")
print("The bank now has \(Bank.coinsInBank) coins")
