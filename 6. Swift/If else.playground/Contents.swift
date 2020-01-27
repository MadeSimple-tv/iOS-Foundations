import Foundation


// If user < 21 --> orange juice
// If user < 30 --> beer
// Else --> vodka

var age = 40
var freeDrink = ""

if age < 21{
    freeDrink = "orange juice"
} else if age < 30{
    freeDrink = "beer"
} else {
    freeDrink = "vodka"
}

freeDrink
