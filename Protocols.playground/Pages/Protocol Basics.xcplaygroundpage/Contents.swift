import Foundation

//: # Protocols
//: Protocols are, as per Apple's definition in the _Swift Programming Language_ book:
//:
//: "... a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to conform to that protocol."
//:
//: The below example shows a protocol that requires conforming types have a particular property defined.
//These are the rules for full names
protocol FullyNamed {
    var fullName: String { get }
}
// Getters and setters
var isOverFifty = false
var randomNumber: Int {
    get {
        return Int.random(in: 1...100)
    }
    
    //    setter will run when you try to set the value
    set {
        print("The value is being set to \(newValue)")
        if newValue > 50 {
            isOverFifty = true
        } else {
            isOverFifty = false
        }
    }
}
print(randomNumber)
print(randomNumber)
print(randomNumber)

randomNumber = 40
print(isOverFifty)
randomNumber = 51
print(isOverFifty)

//Person is adopting the FullyNamed protocol
struct Person: FullyNamed {
    var fullName: String
    //    having the properties/methods of the protocol allows us to conform to the protocol
    
    var favoriteColor: String
    
}

struct Starship: FullyNamed {
    var prefix: String?
    var name: String
    //    if starship has a prefiix add it and the name together to create full name
    var fullName: String {
        get{
            if let prefix = prefix {
                return "\(prefix) \(name)"
            } else {
                return name
            }
        }
    }
}
//: Protocols can also require that conforming types implement certain methods.
protocol GeneratesRandomNumbers {
    func random() -> Int
}

class OneThroughTen: GeneratesRandomNumbers {
    func random() -> Int {
        return Int.random(in: 1...10)
    }
}

class OneThroughOneHundred: GeneratesRandomNumbers {
    func random() -> Int {
        return Int.random(in: 1...100)
    }
}
//: Using built-in Protocols
let me = Person(fullName: "Marc Jacques", favoriteColor: "Red")
let sam = Person(fullName: "Clinton Jacques", favoriteColor: "Red")
extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
////        how can we determine whether values or equal to each other for this example
//        if lhs.fullName == rhs.fullName {
//            return true
//        } else  {
//            return false
//        }
        return lhs.fullName == rhs.fullName
    }
}

// won't work because person isn't "equatable"
//if me == sam {
//    print("They are the same")
//}


//: ## Protocols as Types
class Dice {
    let sides: Int
    let generator: GeneratesRandomNumbers
    
    init(sides: Int, generator: GeneratesRandomNumbers) {
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
        return (generator.random() % sides) + 1
    }
}

