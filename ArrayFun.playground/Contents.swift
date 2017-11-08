import UIKit

var digits = [1,2,3,4,5,6,7,8,9]

// This is nice
if digits.isEmpty {
    print("No digits here...")
}else{
    print("Hey look, some digits")
}

// Your basic for loop
func sumStuff() -> Int{
    var sum: Int = 0
    for i in digits{
        sum += i
    }
    return sum
}

// Me being dumb
typealias collection = [Int]
func coolerSumStuff(digits: collection) -> Int{
    var sum : Int
    sum = digits.reduce(0, +)
    return sum
}

// Want to be explicit, that only functions that return Ints are allowed
typealias timeable = () -> (Int)
// Timing function that takes what you give it
func time(someFunc: timeable) -> (elapsedTime: Double, answer: Int) {
    var elapsedTime: Double
    var answer: Int
    let begin = clock()
    answer = someFunc()
    elapsedTime = Double(clock() - begin) / Double(CLOCKS_PER_SEC)
    return (elapsedTime, answer)
}
// Compare for loop style vs functional style
var results = time{sumStuff()}
print("sumStuff function took \(results.elapsedTime), and the answer was \(results.answer)")
var otherResults = time{coolerSumStuff(digits: digits)}
print("coolerSumStuff function took \(otherResults.elapsedTime), and the answer was \(otherResults.answer)")

