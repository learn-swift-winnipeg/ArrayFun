//: Playground - noun: a place where people can play

import UIKit
var threeDoubles = Array(repeating: 7.0, count: 3)

threeDoubles


// Removing elements
var names = ["bill", "bob", "brad", "steven", "justin"]
// A
//var name = [String]()

names.remove(at: 1)
names

names.removeLast()
names

for name in names {
    print("\(name)")
}

print("")
print("Adding Now...")
print("")

// Adding Elements
names.append("justin")
names
// Also
names += ["bob"]

// Enumerated()
for name in names.enumerated() {
    print("\(name)")
}

var moreNames = ["suzie", "jessica", "tami"]
// Appending an array to an array...appends to the end
names.append(contentsOf: moreNames)

// Append at an index?
print("")
print("More Names")
print("")

for name in names {
    print("\(name)")
}

/////////////////////////
/////// Functions ///////
/////////////////////////
var team = ["brandon", "bary", "mark", "steven"]
// First - returns optional string in this case
if let firstTeamMember = team.first{
    print("The first team member is \(firstTeamMember)")
} else {
    print("You must not have any teammates")
}

// Last - returns optional string in this case
if let lastTeamMember = team.last{
    print("The last team member is \(lastTeamMember)")
} else {
    print("You must not have any teammates")
}



// First(where: {predicate}) - Strings
// - Returns the first element of the sequence that statifies
//   predicate, or nil if there is no element that statisfies predicate
if let result = team.first(where: {$0 == "bary"}){
    print("Found a team member named \(result)")
} else {
    print("No team member found")
}
// Returns nil when it can't statify the predicate
// That drops us down into the else{}
if let result = team.first(where: {$0 == "joe"}){
    print("Found a team member named \(result)")
} else {
    print("No team member found")
}
// With ints
let numbers = [1,34,6,-3,6,4,7,2,-6,34]
if let negativeNumber = numbers.first(where: {$0 < 0}){
    print("Found and negative number: \(negativeNumber)")
} else {
    print("Can't find what you are looking for...")
}



// Filter
let killerBs = team.filter({$0.first == "b"})
print("Killer B's: \(killerBs)")
// Killer B's?
// - The name "Killer B's" was first used on March 31, 1996,
//   when it referenced Jeff Bagwell, Craig Biggio, Sean Berry, and Derek Bell.


// Reduce: NOTE: a string is just a sequence of charaters...arrays are sequences too!
 let letters = "abracadabradsfsdfasdf"
 let letterCount = letters.reduce(into: [:]) { counts, letter in
     counts[letter, default: 0] += 1
 }
print("Letter Count: \(letterCount)")

// Stolen from the Swift Docs
/// When `letters.reduce(into:_:)` is called, the following steps occur:
///
/// 1. The `updateAccumulatingResult` closure is called with the initial
///    accumulating value---`[:]` in this case---and the first character of
///    `letters`, modifying the accumulating value by setting `1` for the key
///    `"a"`.
/// 2. The closure is called again repeatedly with the updated accumulating
///    value and each element of the sequence.
/// 3. When the sequence is exhausted, the accumulating value is returned to
///    the caller.
///
/// If the sequence has no elements, `updateAccumulatingResult` is never
/// executed and `initialResult` is the result of the call to
/// `reduce(into:_:)`.
///
/// - Parameters:
///   - initialResult: The value to use as the initial accumulating value.
///   - updateAccumulatingResult: A closure that updates the accumulating
///     value with an element of the sequence.
/// - Returns: The final accumulated value. If the sequence has no elements,
///   the result is `initialResult`.


// Sort - Strings
// sort() is mutating which means it is changing the original team array
team.sort()
print("Sorted team is \(team)")

// NOTE: sorted isn't mutating...interesting
var sortedNumbers = numbers.sorted()
print("Sorted numbers is \(sortedNumbers)")

// Reverse - Strings
// NOTE: reverse() is also a mutating function
team.reverse()
print("Reversed team: \(team)")

// Append - Strings
// Question: Does it append then sort, then reverse?
    // Do previous operations apply to an array when a new element is added?
team.append("memeguel")
print("The new team: \(team)")

// TODO: Fix
//team.remove(at: )
//print("Get those co-ops outta here: \(team) ")





