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
// Optional
//======================================================================
let i = 10
type(of: i) // Int
let iStr = i as? String // result will be nil
type(of: iStr) // String?
i as! String // will make runtime error and terminate

//----------------------------------------------------------------------


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
// yield the same result as the longer version above. We make use of type
// inference and implicit return since the closure's body is a single-expression
numbers.map({ n in n*3 })
// we can bring the closure out of the parentheses to become a trailing closure,
// because the closure is the last argument to the `map` function
numbers.map() { n in n*3 }
// or even shorter, we can remove the parentheses because the closure is
// provided as the only argument to the `map` function and we wrote it as
// trailing closure
numbers.map { n in n*3 }
// or, we can get rid of the argument `n` by making use of shorthand argument name
numbers.map { $0 * 3 }

// Ref: https://stackoverflow.com/questions/24102617/how-to-use-swift-autoclosure
// without @autoclosure
func f(pred: () -> Bool) {
    if pred() {
        print("It's true")
    }
}
// to call that function, we have to use braces
f(pred: {2 > 1}) // "It's true"

// with @autoclosure
func f2(pred: @autoclosure () -> Bool) {
    if pred() {
        print("It's true")
    }
}
// now, we don't need to explicitly use braces while calling f2
f2(pred: 2 > 1)
// It's true

//---
// -- Functions can "capture" variables that exist in the context they were declared
// Ref: https://airspeedvelocity.net/2014/06/11/a-basic-tutorial-on-functions-and-closures-in-swift/
func returnFunc() -> (Int) -> () {
  var counter = 0  // local variable declaration
  func innerFunc(i: Int) {
    counter += i   // counter is "captured"
    print("running total is now \(counter)")
  }
  return innerFunc
  // normally counter, being a local variable, would
  // go out of scope here and be destroyed. but instead,
  // it will be kept alive for use by innerFunc
}

let f = returnFunc()
f(3)  // will print "running total is now 3"
f(4)  // will print "running total is now 7"

// if we call returnFunc() again, a fresh counter
// variable will be created and captured
let g = returnFunc()
g(2)  // will print "running total is now 2"
g(2)  // will print "running total is now 4"

// this does not effect our first function, which
// still has it's own captured version of counter
f(2)  // will print "running total is now 9"

// A combination of a function and an environment of captured variables is called a
// "closure" in computer programming terminology. So f and g above are examples of
// closures, because they capture and use a non-local variable (counter) that was
// declared outside them.
//----------------------------------------------------------------------


//======================================================================
// Sort an array of number in descending order
// You can refer to parameters by number instead of by name
//======================================================================
let numbers = [3, 4, 2, 5, 1]
let sortedNumbers = numbers.sorted { $0 > $1 }
print(sortedNumbers)

numbers.enumerated().forEach { offset, number in
    print("\(offset): \(number)")
}
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


//======================================================================
// Date time format
//======================================================================
import Foundation
let f = DateFormatter()
f.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
var myDate: Date? = f.date(from: "2017-08-15T22:07:13.000Z")

// iso8601 date time format
f.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
// f.timeZone = TimeZone(abbreviation: "UTC")
f.timeZone = TimeZone(secondsFromGMT: 0)
f.string(from: Date.init(timeIntervalSinceNow: 0))

f.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
// myDate = f.date(from: "2017-08-15 10:43:49 UTC")
myDate = f.date(from: "2017-08-15 14:30:00 UTC")

f.dateFormat = "HH:mm"
f.string(from: myDate!) // print hour and minute in current local timezone

let a = Date.init(timeIntervalSinceNow: -3600*2)
let b = Date.init(timeIntervalSinceNow: 0)
b.timeIntervalSince(a) // find time difference

// adding 3 minutes into `b`
b.addingTimeInterval(3 * 60)

// get hour and minute components from a Date object
let remindDate = Date().addingTimeInterval(30)
let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: remindDate)
//----------------------------------------------------------------------

//======================================================================
// String
//======================================================================
// Trimming whitespaces
import Foundation
let myString = "  \t\t  Let's trim all the whitespace  \n \t  \n  "
let trimmedString = myString.trimmingCharacters(in: .whitespacesAndNewlines)

String(format: "%05d", 3) // padleft a number with 0
let myStr = "Swift"
myStr.characters(at: 0)

    private func createStringIndex(str: String, idx: Int) -> String.Index {
        return str.index(str.startIndex, offsetBy: idx)
    }

    private func getCharAt(str: String, idx: Int) -> Character {
        return str[createStringIndex(str: str, idx: idx)]
    }

// Returns "Let's trim all the whitespace"
//----------------------------------------------------------------------

// create a new UUID (need `import Foundation`)
UUID().uuidString

let jsonData = [
    // "clock_in": Date.init(timeIntervalSinceNow: 0)
    "clock_in": "test"
]
let test = JSONSerialization.data(withJSONObject: jsonData, options: [])

func acc(_ n: Int) -> (Int) -> Int {
    var current = n
    return { current += $0; return current }
}


//======================================================================
// if let
//======================================================================

var x: Int? = 3
if let realX = x, realX > 2 {
    print("x > 2")
}
//======================================================================
//

//======================================================================
// Delay execution of a block of code
//======================================================================
// Ref: https://stackoverflow.com/questions/38031137/how-to-program-a-delay-in-swift-3

// delay 1 second
DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
   // Your code with delay
   print("Hello world!")
}

// or
DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
   // Your code with delay
   print("Hello world!")
}
//======================================================================


stride(from: 2, to: 10, by: 2).map { print($0) }

(["Australia": "au", "Canada": "ca", "Vietnam": "vn"].map { k, _ in k }).sorted { $0 < $1 }
Array(["Australia": "au", "Canada": "ca", "Vietnam": "vn"].keys)
