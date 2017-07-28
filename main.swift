func sayHello(name: String) {
    print("Hello, \(name)!")
}

func factorial(n: Int) -> Int {
    if n <= 1 { return n }
    return n * factorial(n: n - 1)
}

let number = 5
print("\(number)! is equal to \(factorial(n: number))")


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
// closures
//======================================================================
let numbers = [3, 4, 2, 5, 1]
numbers.map({ (number: Int) -> Int in
    let result = 3 * number
    return result
})

// sorter version
// yield the same result as the longer version above
numbers.map({ n in n*3 })
//----------------------------------------------------------------------


if CommandLine.arguments.count != 2 {
    print("Usage: hello NAME")
} else {
    let name = CommandLine.arguments[1]
    sayHello(name: name)
}

