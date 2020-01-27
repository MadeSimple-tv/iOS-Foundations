import Foundation


let firstName = "Bennett"
let lastName = "Lee"
print("Hello \(firstName) \(lastName)")

// DRY - don't repeat yourself!!!

// Define a function
func printName(){
    let firstName = "Bennett =>"
    let lastName = "Lee"
    print("Hello \(firstName) \(lastName)")
}

// Invoking a function
printName()
printName()
printName()
printName()
printName()

// Function with input
func printName(firstName: String, lastName: String){
    print("Hello \(firstName) \(lastName)")
}

printName(firstName: "John", lastName: "Smith")
printName(firstName: "Alicia", lastName: "Jones")
printName(firstName: "Kyle", lastName: "Anderson")

// Function with output
func sum(x: Int, y: Int) -> Int{
    return x + y
}

let result = sum(x: 10, y: 20)
print("The result is \(result)")
