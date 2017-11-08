//: Playground - noun: a place where people can play

import UIKit

var digits = [1,2,3,4,5,6,7,8,9]


if digits.isEmpty {
    print("No digits here...")
}else{
    print("Hey look, some digits")
}

func sumStuff() -> Int{
    var sum: Int = 0
    for i in digits{
        sum += i
    }
    return sum
}

typealias collection = [Int]
func coolerSumStuff(digits: collection) -> Int{
    var sum : Int
    sum = digits.reduce(0, +)
    return sum
}

typealias timeable = () -> (Int)
func time(someFunc: timeable) -> (elapsedTime: Double, answer: Int) {
    var elapsedTime: Double
    var answer: Int
    let begin = clock()
    answer = someFunc()
    elapsedTime = Double(clock() - begin) / Double(CLOCKS_PER_SEC)
    return (elapsedTime, answer)
}
var results = time{sumStuff()}
print("sumStuff function took \(results.elapsedTime), and the answer was \(results.answer)")
var otherResults = time{coolerSumStuff(digits: digits)}
print("coolerSumStuff function took \(otherResults.elapsedTime), and the answer was \(otherResults.answer)")

