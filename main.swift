// Ref: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/

func sayHello(name: String) {
    print("Hello, \(name)!")
}

if CommandLine.arguments.count != 2 {
    print("Usage: hello NAME")
} else {
    let name = CommandLine.arguments[1]
    sayHello(name: name)
}

func factorial(n: Int) -> Int {
    if n <= 1 { return n }
    return n * factorial(n: n - 1)
}

let number = 5
print("\(number)! is equal to \(factorial(n: number))")



//======================================================================
// Control flow
//======================================================================
var total = 0
for i in 0..<4 {
    total += i
}
print(total)
//----------------------------------------------------------------------


//======================================================================
// Objects and Classes
//======================================================================
class NamedShape {
    var numberOfSides: Int = 0
    var name: String

    init(name: String) {
        self.name = name
    }

    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

let squareShape = NamedShape(name: "my square")
squareShape.numberOfSides = 3
//----------------------------------------------------------------------


//======================================================================
// return tuple
//======================================================================
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0

    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }

    return (min, max, sum)
}
let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
print(statistics.sum)
print(statistics.2)
//----------------------------------------------------------------------

//======================================================================
// mutable pass-by-reference
//======================================================================
func adds5ToInput(num: inout Int) {
    num += 5;
}
var num = 3
adds5ToInput(num: &num)
print(num) // 8
//----------------------------------------------------------------------

//======================================================================
// returning a function
//======================================================================
func getDoubler() -> (Int) -> Int {
    func doubler(number: Int) -> Int {
        return number * 2
    }

    return doubler
}
let doubler = getDoubler()
print("Doubled: \(doubler(8))")
//----------------------------------------------------------------------


//======================================================================
// A function can take another function as one of its arguments.
//======================================================================
func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [20, 19, 7, 12]
hasAnyMatches(list: numbers, condition: lessThanTen)
//----------------------------------------------------------------------


//======================================================================
// closures
//======================================================================
let numbers = [3, 4, 2, 5, 1]
numbers.map({ (number: Int) -> Int in
    let result = 3 * number
    return result
})

// shorter version
// yield the same result as the longer version above
numbers.map({ n in n*3 })
// or even shorter, we can remove the parentheses
numbers.map { n in n*3 }
//----------------------------------------------------------------------


//======================================================================
// Sort an array of number in descending order
// You can refer to parameters by number instead of by name
//======================================================================
let numbers = [3, 4, 2, 5, 1]
let sortedNumbers = numbers.sorted { $0 > $1 }
print(sortedNumbers)
//----------------------------------------------------------------------


//======================================================================
// Protocol (similar to interface in Java?)
//======================================================================
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

// Classes, enumerations, and structs can all adopt protocols.
class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += "  Now 100% adjusted."
    }
}
var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription

struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}
var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription
//----------------------------------------------------------------------

//======================================================================
// matching
//======================================================================
let test: UInt32 = 5
var description: String = ""
switch test {
    case 0..<10:
        description = "less than ten"
    default:
        description = "greater than ten"
}
print("\(description)")
//----------------------------------------------------------------------

//======================================================================
// sort the value (which is an array in this example) in-place of each key
// in a dictionary in descending order
//======================================================================
var interestingNumbers = ["primes": [2, 3, 5, 7, 11, 13, 15],
                          "triangular": [1, 3, 6, 10, 15, 21, 28],
                          "hexagonal": [1, 6, 15, 28, 45, 66, 91]]
for key in interestingNumbers.keys {
    interestingNumbers[key]?.sort(by: >)
}

// print the newly in-place sorted array of key "primes"
print(interestingNumbers["primes"]!)

// iterating over the contents of a dictionary
for (key, val) in interestingNumbers {
    print("'\(key)' contains array of '\(val)'")
}
//----------------------------------------------------------------------

