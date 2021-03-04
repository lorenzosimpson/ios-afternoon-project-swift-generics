import Foundation

struct CountedSet<Element: Hashable> {
    
    typealias ArrayLiteralElement = Element
    
    private(set) var storage: [Element: Int] = [:]
    
    mutating func insert(_ element: Element, occurences: Int = 1) {
//        if let count = storage[element] {
//            storage[element] = count + 1
//        }
//        else { storage[element] = 1}
        
        storage[element, default: 0] += occurences
    }
    
    mutating func remove(_ element: Element, occurences: Int = 1) {
        if let count = storage[element] { storage[element] = count - occurences}
        else { storage[element] = nil}
    }
    
    subscript(_ element: Element) -> Int {
        if let count = storage[element] {
            return count
    } else {
        return 0
        }
    }
    
    var count: Int {
        return storage.count
    }
    
    var isEmpty: Bool {
        return storage.isEmpty
    }
}

extension CountedSet: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self.init()
        for element in elements {
            insert(element)
        }
    }
    
    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == Element {
        for element in sequence {
            insert(element)
        }
    }
    
    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == (key: Element, value: Int) {
        for (element, count) in sequence {
            insert(element, occurences: count)
        }
    }
    
    
}


enum Arrow { case iron,
    wooden,
    elven,
    dwarvish,
    magic,
    silver }

var aCountedSet = CountedSet<Arrow>()

aCountedSet[.iron] // 0
var myCountedSet: CountedSet<Arrow> = [.iron, .magic, .iron, .silver, .iron, .iron]

myCountedSet[.iron] // 4
myCountedSet.remove(.iron) // 3
myCountedSet.remove(.dwarvish) // 0
myCountedSet.remove(.magic) // 0

myCountedSet.insert(.dwarvish)
myCountedSet[.dwarvish]


var instruments = ["Saxophone", "Trumpet", "Piano", "Clarinet", "Violin", "Guitar", "Drum"]
var jacobsonInstruments = CountedSet(instruments)
jacobsonInstruments.insert("Saxophone")
jacobsonInstruments.insert("Saxophone")
jacobsonInstruments.insert("Saxophone")
jacobsonInstruments.insert("Saxophone")
jacobsonInstruments.insert("Saxophone")
jacobsonInstruments.insert("Clarinet")
jacobsonInstruments.count
jacobsonInstruments["Saxophone"]

var livestock = ["goat": 4, "pig": 7, "chicken": 20]
var barn = CountedSet(livestock)
barn["pig"]
barn.remove("pig", occurences: 1)
barn["pig"]
