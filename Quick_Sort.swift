struct Person: Comparable {
    let name: String
    let age: Int
    
    // Implement the Comparable protocol by providing the `<` operator
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.age < rhs.age
    }
}

func quickSort<T: Comparable>(_ array: inout [T], low: Int, high: Int) {
    if low < high {
        let partitionIndex = partition(&array, low: low, high: high)
        
        quickSort(&array, low: low, high: partitionIndex - 1)
        quickSort(&array, low: partitionIndex + 1, high: high)
    }
}

func partition<T: Comparable>(_ array: inout [T], low: Int, high: Int) -> Int {
    let pivot = array[high]
    var i = low - 1
    
    for j in low..<high {
        if array[j] <= pivot {
            i += 1
            array.swapAt(i, j)
        }
    }
    
    array.swapAt(i + 1, high)
    return i + 1
}


var people = [
    Person(name: "Alice", age: 30),
    Person(name: "Bob", age: 25),
    Person(name: "Charlie", age: 35),
    Person(name: "David", age: 28)
]

let n = people.count
quickSort(&people, low: 0, high: n - 1)
print("Sorted People: \(people.map { $0.name })")