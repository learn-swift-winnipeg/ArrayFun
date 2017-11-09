import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

// Koodos for discovering the `arc4random` functions. Don't you wish Swift had a more native way of accomplishing this? I sure do. In fact I usually add some static functions to Int and Double in `extensions` to make this a little more readable. i.e. `static func random(lower: Int, upper: Int) -> Int`. Then the call site reads `let randInt = Int.random(lower: 0, upper: 100)`.
let randNum = arc4random_uniform(100)
let randInt = Int(randNum)

// I increased the count in order to get larger execution time measurements.
var digits = Array(repeating:randInt, count: 100_000)

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
var sumStuffQueue = DispatchQueue(
    label: "sumStuffAsync",
    // `qos` stands for Quality Of Service and determines how much system resource is allocated to the queue. Try experimenting with different qos settings to see the effect on execution time. Hint: Try `.userInteractive`.
    qos: .background
)

// Your basic for loop ~ With a little sizzle

// I love that you're testing synchronous vs asynchronous code however there are some issues here:
//
// 1. This function is returning a result synchronously (`-> Int`)... but that doesn't make sense if the work is being done asynchronously. There can/will be inconsistent results depending on which lines of code execute first. I recommend returning the value asynchronously via a callback closure.
//
// 2. The digits array should probably be passed in rather than accessed as global variable.
func sumStuffAsync(digits: [Int], completion: @escaping (Int) -> Void) {
    
    // 2. `globalSum` is being created on the main queue but will be modified later from the background "sumStuffAsync" queue. While this won't cause any issues in this specific case, it's very easy to create all kinds of crazy bugs by modifying values from different queues at the same time. As a general rule I recommend creating and modifying values/properties from a single queue exclusively. In this case you won't even need a globalSum variable because the value of `sum` will be returned directly via the callback closure.
    sumStuffQueue.async{
        var sum: Int = 0
        for i in digits{
            sum += i
        }
        
        // 3. We should probably call the completion closure on the main queue because callers of `sumStuffAsync(:)` will probably assume it's that way. We could introduce hard to trace bugs if we returned the value on a background queue without letting the callers know it. They may start attempting to update the UI without realizing they're not on the main queue.
        DispatchQueue.main.async {
            completion(sum)
        }
    }
}

// Me being dumb

// I like the use of `typealias` here but I recommend two changes:
//
// 1. The Swift API Design Guidelines (https://swift.org/documentation/api-design-guidelines/#follow-case-conventions) recommend naming Types and Protocols using UpperCamelCase and using lowerCamelCase for everything else.
//
// 2. `Collection` is already the name of a protocol in the Standard Library and it doesn't add any extra information about the context here. I recommend using something like `Digits` or `Integers`.
typealias Digits = [Int]

func coolerSumStuff(digits: Digits) -> Int{
    var sum : Int
    sum = digits.reduce(0, +)
    return sum
}

var coolStuffQueue = DispatchQueue(label: "coolStuffQueue")

// The same async issues exist here as the func above.
func coolerSumStuffAsync(digits: Digits) -> Int{
    var globalSum = 0
    coolStuffQueue.async {
        var sum : Int
        sum = digits.reduce(0, +)
        globalSum = sum
    }
    return globalSum
}

// Want to be explicit, that only functions that return Ints are allowed
typealias Timeable = () -> (Int)

// Timing function that takes what you give it
func time(someFunc: Timeable) -> (elapsedTime: Double, answer: Int) {
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


// Now that the async funtions are returning results asynchronously we will need another timing function to deal with them.
//
// Warning: This gets complicated; a little mind bending.
//
// In order to measure the time of an async function we'll need a way to know when the async function under test completes, then calculate the time elapsed afterwards. So whats really happening here is `measureExecutionTime()` is providing a "callWhenFinished" closure as the parameter to the passed in `someAsyncFunc` closure (`@escaping (Int) -> Void`). I know, it's a little like Inception. Later when we test sumStuffAsync we'll call this "callWhenFinished" closure to indicate that the summing function finished and provide the result.
//
// That leads to the second `completion` closure which returns the elapsedTime and answer to the caller.
func measureExecutionTime(
    of someAsyncFunc: ( @escaping (Int) -> Void ) -> Void,
    completion: @escaping ((elapsedTime: Double, answer: Int)) -> Void)
{
    let begin = clock()
    
    someAsyncFunc() { result in
        let elapsedTime = Double(clock() - begin) / Double(CLOCKS_PER_SEC)
        
        // Return result to caller.
        completion((elapsedTime: elapsedTime, answer: result))
    }
}

measureExecutionTime(of: { callWhenFinished in
    sumStuffAsync(digits: digits) { result in
        callWhenFinished(result)
    }
}, completion: { result in
    print("sumStuffAsync function took \(result.elapsedTime), and the answer was \(result.answer)")
})

// Note the XCTest framework uses something called Expectations for testing async code. Check it out an example of a better async testing API than what I hacked together here: https://developer.apple.com/documentation/xctest/asynchronous_tests_and_expectations/testing_asynchronous_operations_with_expectations

var otherResults = time{coolerSumStuff(digits: digits)}
print("coolerSumStuff function took \(otherResults.elapsedTime), and the answer was \(otherResults.answer)")

// The same async issues exist here as the func above.
var coolerResults = time{coolerSumStuffAsync(digits: digits)}
print("coolerSumStuffAsync function took \(coolerResults.elapsedTime), and the answer was \(coolerResults.answer)")

