import Foundation

protocol Moveable{
    func moveForward()
    func moveBackward()
}

class ToyCar: Moveable{
    func moveForward(){}
    func moveBackward(){}
    func honk(){
        print("honk! honk!")
    }
}

class Skateboard: Moveable{
    func moveForward(){}
    func moveBackward(){}
    func kickFlip(){
        print("kick flip")
    }
}

let inventory: [Moveable] = [ToyCar(), Skateboard(), ToyCar(), Skateboard(), ToyCar(), ToyCar(), Skateboard() ]

var numberOfSkateboards = 0
var numberOfToyCars = 0

inventory[1] is Skateboard

for element in inventory{
    if element is ToyCar{
        numberOfToyCars = numberOfToyCars + 1
    }
    
    if element is Skateboard{
        numberOfSkateboards = numberOfSkateboards + 1
    }
}

numberOfToyCars
numberOfSkateboards

// Downcasting

if let toycar = inventory[1] as? ToyCar{
    toycar.honk()
}

for element in inventory{
    if let toycar = element as? ToyCar{
        toycar.honk()
    }
    
    if let skateboard = element as? Skateboard{
        skateboard.kickFlip()
    }
}

// Force downcasting
let toycar = inventory[0] as! ToyCar
toycar.honk()
