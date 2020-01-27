import Foundation

var superHeroes = ["Spiderman", "Superman", "Wonder Woman"]

// Properties
superHeroes.isEmpty
superHeroes.first
superHeroes.last

// Methods

superHeroes.append("Captain Marvel")
superHeroes.insert("Batman", at: 1)
superHeroes.removeLast()
superHeroes.remove(at: 2)
superHeroes.contains("Black Panther")

// Subscript Notation
superHeroes[2]
superHeroes

// Iterate through an array's content
for superHero in superHeroes{
    print("i love \(superHero)")
}
