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




