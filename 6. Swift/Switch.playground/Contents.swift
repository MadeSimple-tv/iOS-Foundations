import Foundation


var favoriteColor = "red"
var message = ""

switch favoriteColor {
    case "blue":
        message = "Me too!!!"
    case "orange":
        message = "Not sure about that one"
    case "red":
        message = "That's very intense"
    default:
        message = "Interesting"
}

message
