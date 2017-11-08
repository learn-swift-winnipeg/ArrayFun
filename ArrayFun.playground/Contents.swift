import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true


let randNum = arc4random_uniform(100)
let randInt = Int(randNum)

var digits = Array(repeating:randInt, count: 100)

print("Summing \(digits.count) numbers")

// This is nice
if digits.isEmpty {
    print("No digits here...")
}else{
    print("Hey look, some digits")
}

// Traditional For-Loop approach
func sumStuff() -> Int{
        var sum: Int = 0
        for i in digits{
            sum += i
        }
    return sum
}
// Dedicated Queue for sumStuffAsync()
var sumStuffQueue = DispatchQueue(label: "sumStuffAsync")
// Your basic for loop ~ With a little sizzle
func sumStuffAsync() -> Int{
    var globalSum = 0
    sumStuffQueue.async{
        var sum: Int = 0
        for i in digits{
            sum += i
        }
        // Error with this
        globalSum = sum
    }
    return globalSum
}

// Me being dumb
typealias collection = [Int]
func coolerSumStuff(digits: collection) -> Int{
    var sum : Int
    sum = digits.reduce(0, +)
    return sum
}

var coolStuffQueue = DispatchQueue(label: "coolStuffQueue")
func coolerSumStuffAsync(digits: collection) -> Int{
    var globalSum = 0
    coolStuffQueue.async {
        var sum : Int
        sum = digits.reduce(0, +)
        globalSum = sum
    }
    return globalSum
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


// Compare for loop style vs functional style vs Async style
var results = time{sumStuff()}
print("sumStuff function took \(results.elapsedTime), and the answer was \(results.answer)")
var asyncResults = time{sumStuffAsync()}
print("sumStuffAsync function took \(asyncResults.elapsedTime), and the answer was \(asyncResults.answer)")
var otherResults = time{coolerSumStuff(digits: digits)}
print("coolerSumStuff function took \(otherResults.elapsedTime), and the answer was \(otherResults.answer)")
var coolerResults = time{coolerSumStuffAsync(digits: digits)}
print("coolerSumStuffAsync function took \(coolerResults.elapsedTime), and the answer was \(coolerResults.answer)")

